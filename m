Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729618;
	b=P6/fCU9Ka6Sc30WGclZJIfRuEQXI7oCfcyZDDJLc+Va3eZTUBMx+pRKlwLxIoEb6Q7VU
	 gvE7RLG7qC3mTZjLWbY+Tr7zfxGLcpspTCURUKigILsu1Pui+3ij4KOh06x9RzRlfIolg
	 CQQr5cKJgbwnsa6gB6D7sXlo3cS/umQxUzZNKn+iZifmB2+CZ3q8Q4wzPVaSY/rdOd5y/
	 B/OKWdKedENEQuT5bEHA8W044jW+iLeRAvs5vnHXHUjQ/6Bhqpy+7+C1Y58ao+Zx/bCF0
	 irOWrdL+ap10blr5umU9kbv3XpzkTFxxmLUoav33uJzj9DQDzPATs+W6MuUKBoRUwig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729618;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=pVtrMU7n52ooXdNq+lpQ3zgKtsDLo3BaU4iRR5TFMs8=;
	b=i+iXRZpwgm1w/MMaAOoUVwAmIQwdYDFEGQXKMSH3DArDSCDusK2NcXLb4/UrkKLwigqp
	 d4uJL6eYAdrajcgKM6rQJYEVoyRbYkId6aGopvGTeWyT+CDmHo7AhSUczWqIQ5A+tmU4s
	 yt7TEzv/jsjqh2qPkp09dlr4NjKBZzs19ywAX/LEcmyD2LLOXLQZ/ePkBPAS1BwrSNTdv
	 qWkh9s4YOONBxjE92i3PFCQF5xF/rCQYZmaE7JvkoiJo1Aycqq6A9HmBS7nsnOr1Zqdy4
	 gvFnsBJ2OphOWcE+vQrSPX6yUnF9rDL3Fgihuaaf5o7xwcCF36/+RR358T7QGp18XkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=NPx9eIe8;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E348606A32E;
	Tue,  3 Nov 2026 18:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E348606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=NPx9eIe8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pVtrMU7n52ooXdNq+lpQ3zgKtsDLo3BaU4iRR5TFMs8=; b=NPx9eIe8q2jnNiOhR8lNIH2nbd
	x2uxVlgEb7vnovP3eokzczvDPtn4XDBb6M7hikwgkGjcCM1/J5yn5yfIdDw4mbJd+3WZmZux6M1b/
	K1BCBH5rhoaMLkiDP0CE8s0jsRkl9xL8hWG2PdtT1CsedFBMi3cgEviwg/O3a6OOQnu7hSQawFGOZ
	B/VTGwJ/I73BCZj5GGAmauhKYy3mfgtpp2MjJGDiBHtIzDwjPuERp4erisYRDmgoug2BPpYlbrf4W
	VjY012L8xA9ymf8YSTn+iIPUt5jpqByzBqBZmmh0Xu+oaWrPLjvOOdh3EhHRRdDHlXiJhMG6wPSc+
	TCSYT17Q==;
Received: from [::1] (port=37464 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xOJ0l-00000008Y2C-3Gdf;
	Tue, 03 Nov 2026 19:13:30 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 19:13:30 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Alexander Aring <aahringo@redhat.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] dlm: reject wrapped messages with oversized inner lengths
In-Reply-To: <CAK-6q+g8ZFFWRZfhW5AsKM3_LcxBei_RdBfxgSdsa=x8=7b+jA@mail.gmail.com>
References: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAK-6q+g8ZFFWRZfhW5AsKM3_LcxBei_RdBfxgSdsa=x8=7b+jA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <868a092d4d27c0f8999057916b1de4da@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-18 21:19, Alexander Aring wrote:
> Hi,
> 
> On Tue, Aug 18, 2026 at 10:28 AM Jérémy Jean
> <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> 
>> Reject DLM_OPTS packets whose wrapped inner message length exceeds the
>> bytes remaining inside the validated outer packet. This keeps 
>> malformed
>> wrapped RCOM replies from reaching downstream length-driven copies.
>> 
>> Fixes: 489d8e559c65 ("fs: dlm: add reliable connection if reconnect")
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>
> 
> Thanks!
> 
> - Alex

Hello,

Has anyone had time to check or process this further?
Current commit on master still has the issue.

Regards,
Jérémy
