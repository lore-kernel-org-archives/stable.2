Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.48.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364903;
	b=mNdJ6a6+VRcZEnZUxDBb0a9wJsNgnl29ccztGtOPgwjErJdqBGxIcMr4gGUL2pM4omY7
	 fwQoTQTqfNXSTcJWDtgosCHc7PCoe0nYC63Py/Fkt4QsEkJWyeJFswVkocbeFT5ID9xrz
	 kpx6k50T0MK1B0tnQCwOx0jHHEpXxoaNGnTAzJ+jDed1Q9cvb+z3QTS20bCBjrlPT6uYD
	 aGVgyxx5UUFs4fckMhR3vKOPw5DGiZGzznFL5UnJwxn7cOumzI9IScikt0LIWZPHjXyjw
	 CqjBEYuemH7XV109xWLf1Vdc67cbg/a9OAdG+SmmOBneDNMbxiPdh4xvOjYuZ1YLaug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364903;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=Y6J9BBnU4fABb83GyABeux2c6o/ibtAfqfZDo8SSL4s=;
	b=LXfh0PZxM5hOMek4ksrWRtfkXUXCKGbLL+aGA9iiFHZH+Ftf7+crlBiLyM18Oc1hZlAt
	 c3jB1QR2kzWz8lTP6WUtQeGtqBGyiVKzDaJ2f6KlJjWUTWaGPRbATCyTuWGyAGrAIIDlb
	 fVUuWdrb21wgv1vaPvgICNHVAiuyIjg2VYHCUVA/+Aal5xEJS+up4nmY1J6Pl3SHcqCVZ
	 2cXoBmosHBipsqBulnSNfuxSbnDB11ICfyNM+8vAlcgn9fR7KokVqsW2XlJV3mji1vQKt
	 EC6TqvrTfK6qkiGSxYRXd3r86sQmDBKggMDMCtOMREgoooJobnbcMsbVi7JeeK+tm6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ahmedabdelfattah.dev;
	spf=pass smtp.mailfrom=send.ahmedabdelfattah.dev;
	dkim=pass header.d=ahmedabdelfattah.dev header.i=@ahmedabdelfattah.dev header.a=rsa-sha256 header.s=resend header.b=ox2fG0Wi;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=At2+Qnn1;
	arc=none smtp.remote-ip=54.240.48.56
Received: from a48-56.smtp-out.amazonses.com (a48-56.smtp-out.amazonses.com [54.240.48.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC7606A320;
	Sun, 22 Nov 2026 16:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AC7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ahmedabdelfattah.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.ahmedabdelfattah.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ahmedabdelfattah.dev header.i=@ahmedabdelfattah.dev header.a=rsa-sha256 header.s=resend header.b=ox2fG0Wi;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=At2+Qnn1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=ahmedabdelfattah.dev; t=1795364902;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=r+rqUyXdaNAvzuO9p5Cq/rai/19+eqNqPr0AEDhIax8=;
	b=ox2fG0WiK7+yU4D/y6qiYVnobJh3b4OQqyYs60rvbWNpFt+E1q9aw1mvvoXC7Jpe
	Dm+c3Miz7iMBnF3Rf2RBddYlhXAnTZ5uCMyXrrq+LVn0Wz78yst/9BzLWDdj81+I0g3
	1WFG/3A24yT2zu2noxbrmODOcnDbT4QD3x/r2sYU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1795364902;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=r+rqUyXdaNAvzuO9p5Cq/rai/19+eqNqPr0AEDhIax8=;
	b=At2+Qnn1OXArw9u2ztbrCBCWCYu+ZXkgDQKX1BwnJANojrvWykmU3AsVDeSKGGOY
	UiWDQ8xsbucUxgtHLUV5uurpRpMwUWDzXUlrOFKof6KUOT2St4Rqjyk9Wcud+fv/bmj
	Nxq4pWClvI+XODQ8Eigh4I2vQuaxeGpGWJDCvK5Q=
In-Reply-To:
 <CY8PR12MB729059D6B66095F842FD470FD1462@CY8PR12MB7290.namprd12.prod.outlook.com>
References:
 <20261119-edac-ie31200-rank-stride-v1-1-3514fcccb130@ahmedabdelfattah.dev>
 <CY8PR12MB729059D6B66095F842FD470FD1462@CY8PR12MB7290.namprd12.prod.outlook.com>
From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
To: "Qiuxu (Leo) Zhuo" <qzhuo@nvidia.com>
Cc: Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/ie31200: Give each DIMM two chip selects again
Message-ID: <010001a204165494-b76809e7-e171-4a1e-8da4-a1dcd2df4f6b-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Nov 2026 16:28:22 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.uCKvsN4fow5iTxhgdfCiLkD52dLS8e5zeZeNIHIyObThYgWj6io55JEpA9Lr59BibvMHOQwybONW0pi/CZ0koY1A1i17AG2yWEV8SeTaUDUkRN5zlcaoQEhviEafOoOqtPZhQs319GE3nsx7+JZeBdmAUyq6td6+kg0Qy2oXHvo=:1.us-east-1.pAEstvQcjyhQNKGKcgSlzI7SVR8ZSG5wSmKwiz/A8Dg=:AmazonSES
X-SES-Outgoing: 2026.11.22-54.240.48.56

On Sun, Nov 22, 2026 at 04:02:12PM +0000, Qiuxu (Leo) Zhuo wrote:
> For comparison, Intel Ice Lake servers decode the per-channel rank ID
> from MCi_MISC as
>
>   DIMM 0: ranks 0, 1, 2, 3
>   DIMM 1: ranks 4, 5, 6, 7

Thanks, that is a useful comparison. With a fixed block per DIMM on the
server side, 0-1 and 2-3 looks like the natural layout here too, even
with the RPL-S encoding unconfirmed.

> The change looks good to me.
>
> Reviewed-by: Qiuxu Zhuo qzhuo@nvidia.com (qzhuo@nvidia.com)

Thank you for the review. The angle brackets got lost from the tag on
the way, so b4 does not pick it up. If I send a v2 I will carry it as

  Reviewed-by: Qiuxu Zhuo <qzhuo@nvidia.com>

Thanks,
Ahmed
