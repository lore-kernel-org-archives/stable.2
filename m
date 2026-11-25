Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596974;
	b=YTSbFOEZ0ayol7N5JR7CSUQg/RhqESitmwPze0FyM6TxqqL8Sed3F3jQMpl0PrVU5YAd
	 xukO2Da4bprs/ePnmxW400R06gNNsyi211E1FRYRMICWhgBMGd7Qcta1VOWwunTh8E1Q3
	 6zNP6zTEK/UIoGfUc4UjR17tq6gf2hNjXO5a6JJ9pGoIxvwsN0cpgReTM4uBfW7SyIt7R
	 V21PW5KycD1Xm6iHo6+ahHVScn/U27VDcRRr+Ja0zxheasS+6Rh3zarEC5sNtv3L0mfBy
	 9NjQ9b6H8aWA/9kTjaGRrPsQ5KxJfQ4PNkbs9oqh0q9I0AN4A4yCESJzlimgglUpFRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596974;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ljLbc0qiiR1WToszwYax/weK8DFXbY5oz9wSwFc6vMY=;
	b=0aF+S3Fk+ESci/v5I5VAv60LVncN3jwIXhRUyOFqkOOR48drvOva6CLviO++xZ1BwwVf
	 C5CldaW+4uT8m88WoX142QJjZJhuw6xJnZrWErQIGzHZuYitPOC9be8mjGJ+Sgn2QNnzz
	 IA+0lMP/8bAwX3hKJcFbm7Uq1qp6puV/IH9+OItapp+c3OREYgZCn1vCpm85V9PJxSpYT
	 S2+WXwBqeE/wBTAScs235Cs7L5zvaD9XHYFiFWpx3ojBuT5OK3Dm/xaoU5GwBmjS7IIZg
	 bQZwMl+/kaFkY6oeSEpk/Z0R4V8noCm5+1ySVBmqRCjTxPdw1EvCRX0m+YVzsNjmb/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxLV0GbH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92A606A31E;
	Wed, 25 Nov 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxLV0GbH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B91F000D0;
	Wed, 25 Nov 2026 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596973;
	bh=ljLbc0qiiR1WToszwYax/weK8DFXbY5oz9wSwFc6vMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OxLV0GbHL+q25gxouO6hT6wN5QYmY/WPV6vDkvh1rEQiK8RrgDBROkzZ7gBeP/GQQ
	 mg5wHss5lP4tOV3qYMmvnJ2oSnJ4HJgONDu6xYanQs8+z5H6aSOFdv1Vw5ZhooeOS6
	 zvgFy3rinwUnVlTlZSZcR6woCDO6lZ9HBoAa1a562lew8GncuYKjBf7UnkCWlVyM5l
	 GfeIYFdji8Jxn+XQ+hl1lIMGpmHxpzDMl0xqRBSaoDbYHkbligwUjLFt18TGlWszQg
	 jGBJO108DZlRc0dFsS6jwlokBELauwS0n44HlKfxqhyhKCsuAXXXa4O2+Fwph8H297
	 rpKhKAoMUKMag==
Date: Tue, 24 Nov 2026 22:56:12 -1000
Message-ID: <c015ca9271f8c9ab91c9b4394061229e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes 2/2] sched_ext: Start ext_server on every enqueue
In-Reply-To: <20261123-scx-dlsrv-v1-2-87c342d8246e@gmail.com>
References: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com> <20261123-scx-dlsrv-v1-2-87c342d8246e@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Hang.

On Mon, Nov 23, 2026 at 02:04:55AM +0800, Hang Zhengyang via B4 Relay wrote:
> This doesn't cover a task that another CPU dispatches to this CPU's
> local DSQ.

This is a known problem and I'm afraid starting ext_server on every
enqueue isn't enough to address it. Which rq a task is enqueued on doesn't
tell which CPU is going to run it, so ext_server can still stay stopped
with tasks waiting for the CPU and no enqueue to start it again. The case
above is one example. With scx_central and a SCHED_FIFO task spinning on a
CPU, a SCHED_EXT task pinned to the same CPU still stalls for over ten
seconds with this patch applied.

I think this needs a different approach. I'll post something for it.

Thanks.

--
tejun
