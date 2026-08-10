Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25C18CC13;
	Mon, 10 Aug 2026 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405538; cv=none; b=u3OC99iPNyMuKngGo17uvzfqo1nIdQQg/OKifxLQZPzHFaLyd4pJYqfkd9Piwo8WH+IGkC7mQwYlMKaufx8eiPSUAp963QTPnwQ4JI6e5GOhTFXOcCoIHXOZFqPlBHClKgUmy+27s33DOdXhR9NV5KAKHiUxlhm64hEdAjMlxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405538; c=relaxed/simple;
	bh=wS0HIXcI+FE94Q76pfTx/kzPnWsLeIs24k2m7bHk2w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXUmpOCcfkmsKyhdVIxFBQQuyPKEMC7N5359gO76C8nsYG8lElbnneDv8JU1ScrtLUpLTZx/SEGXy8Hwx1YRDRt8L8k0mt3fyslM1TrMQmA6Ynch2TPtzfAjRUbI6uPt3EnJO15sXeDg0nZxxh2q+LFzs7zYIjYapBzUVqEGL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEyRmS9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEyRmS9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14881F000E9;
	Mon, 10 Aug 2026 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405537;
	bh=9mUFtIsPj1Qkk9XdRL1tMXaLPipwNeRDSJDAxaEHSoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kEyRmS9uCJykNWvd6BGBiBtp1dFDvI6xdLzeKwmbVKnoErUOqpcD9CuQFmYFqm/EC
	 yKmAqqwoF8T9oLGtUrUnKVtaghpF+YRDfLmkeC/VQFsFULG9nJ0x5HkZpia8Vb0TI3
	 8qHOsttjMXQVGzC5nFwWm7JCZ6jZyDvngJ+Uz3mO5Yrbjoc0Yb1pVS669MPFrVwBZi
	 ql65EoNg106Hy+iKK0r4FTSvNSwO4L5X9fNEqet9ob8xslF7ZPHD+f7Qzz5ILbvHMK
	 Rp37CdSXZRwkD3o8RKrFz/ioMhseTpYml0YQzwONKAQj2eTNvAOTs28sDjBG81tqZr
	 Zv8TwmX7cGdWw==
Date: Mon, 10 Aug 2026 16:45:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, Victor
 Nogueira <victor@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>, Jiri
 Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on
 a->goto_chain
Message-ID: <20260810164536.6ecf043d@kernel.org>
In-Reply-To: <20260809090928.868186-1-jhs@mojatatu.com>
References: <20260809090928.868186-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Aug 2026 05:09:28 -0400 Jamal Hadi Salim wrote:
> tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> rcu_access_pointer(a->goto_chain) and then calling
> tcf_action_goto_chain_exec(), which does a second, independent
> rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
> replace path) can clear a->goto_chain between the two reads, so the second
> read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.

FWIW *shiko suggests another tweak but looks orthogonal, LMK if you
disagree:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809090928.868186-1-jhs@mojatatu.com

(the patch is "too fresh" for me to apply right now anyway)
