Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07B364EAA;
	Thu,  8 Oct 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479540; cv=none; b=fBIdMQodoXQOXkwbufKjA9bf5JC4KB0wJe2JQTrmJup3Z8/jojpwf15eAphlB0kvBQXwebjBNHSeSznEM5ga7c9kPGh645Xvxv3X6r+KLaJ5sn9+vajg+he8FCv2SAUSRvwokYkePbQT8hqZ7O1yB78lSytoIja1PPZAyQJlW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479540; c=relaxed/simple;
	bh=QCAItNjgWKT1ojmHEfdoUX+wEOXTJpjstvc96v0viYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qlm50xHS3l1fpHsdaxH68SgBsfOovsGwl0nqTO29IWI9OEIBFerVQ+H+S/4brNNQ1404HRPYPSdf6JEzZZwJXfXOKLRVcI+9xQ1wypoup6yKVW5t6CxplQ/5H1SZY8CDJEYDsYDsAoz4cz3W3ZH6wOMYMNbZVYZlQECbZv+F2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiIpYK6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiIpYK6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F81F000FF;
	Thu,  8 Oct 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791479539;
	bh=QCAItNjgWKT1ojmHEfdoUX+wEOXTJpjstvc96v0viYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aiIpYK6RzIPr/nh1CRUn39qNoMcengfZaapNPup8327L0RHLEHEdJIDHhoMMJjRu8
	 uDKZ+Dtxspvq1XJsNSnFzJ6lwgpYKZPeNT2eD8g0FXfxLXV2+2yg5fu/faWJuVyBPH
	 jzDgxOX5NG/iBojABktjLUNU56EltAtsyGXCdVvso4TnEPvfZYjEEKKS6BUEL/m5wO
	 /FK+65O6AYcXGsI6r6BkpYsk4r6hRHX1dQN5gS4CyD3KVRW0DYAbiGMd0MxJ/Kw6iq
	 Tqj8El0nIbyGH9kcZiVtaR4B8N5e5E7vSoiif3+syZ1K1gCRLOiq23fOBirplbjnvP
	 h8ZmC6oIyAu/Q==
Date: Thu, 8 Oct 2026 10:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: fix use-after-free in __tcf_action_put()
Message-ID: <20261008101218.18b0a4fe@kernel.org>
In-Reply-To: <776ed0c422ace98fd907468f78ea9cb0@oss.cyber.gouv.fr>
References: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<20261007173503.588b9c7f@kernel.org>
	<776ed0c422ace98fd907468f78ea9cb0@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Oct 2026 11:03:42 +0200 J=C3=A9r=C3=A9my Jean wrote:
> Indeed, you are right: there was no specific reason for the inversion.
> Below is a new fix suggestion.
> If you agree with it, I could send it as a v2.

LGTM, please send
