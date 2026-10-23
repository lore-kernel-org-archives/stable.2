Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753536;
	b=RtTmho4Z7nJ8X2fOfS1IMuQPzvcYMq2Lj25dgSLFbsbQY+XdBZlcRMFpvHUNcCqf1Xy5
	 Z8qLiOKjLcl+5dM7KU/chjiBxFUlmiLvEyHfZJfb9khNOYLWOJOBZb+WZZIkwqQ0Hk24F
	 Lsgv77s8G8q2cd9+zjZWqUym3ZQMyexaMya9d/UJ7+lTlE1oZ1Mh/ICs8PyrKI3+o7fXc
	 z0/fJdWTQoZIU0+NLeVrTlz3NYiLr8KZS4wsbwkDjeKu/KpQ9xzVK+xM8juk4y24mJBss
	 TOZ8yOVFB4sJy7simulv6LVDZE2TKwcwePGNbCEYJPpRGvRFnDuJ4OFKq41e9bvHYsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753536;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=waKvb1FH9J1TaFH1KLeAlG3y2zTlQK6lDbbFSogLHDs=;
	b=5iKlZ/Zn8hAfzxDOwcupbrPGd8yUyeoHEVGd9MRa1jCJS2dh8fTe1ARyr+eu71GP2ov0
	 rv/gTz6LU6pOYv8T2+hPjK+RnB7MuvwpFI9JOXOH224n3TKAZVzY4efbdkJzBqKccM3DV
	 JBssPnk6xRQdMoyJgxSm+01p6lWmEgHs5iWQTPWC9/+35HN5mAMv4zm2Zks45dkoFJeH9
	 kBdCLg9irQcm/5HOfVXonlLqwtXKz2h/rBHLWLklBmrcBTMUWN+rUorBLA/TeN++CKWIu
	 zZEtytuOZk0GU3IivOsHf6RDUkyB20rCCF0JaRHQyz51KGJBHyvt+EsD08gw5cTqs4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4652606A31A;
	Fri, 23 Oct 2026 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4652606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Mehmet Fide <mehmet.fide@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Michail
 Andreas Michalopoulos <mike.michalo@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath9k: don't read past short WMI command
 responses
In-Reply-To: <20261020152412.95560-2-mike.michalo@gmail.com>
References: <20261020152412.95560-1-mike.michalo@gmail.com>
 <20261020152412.95560-2-mike.michalo@gmail.com>
Date: Fri, 23 Oct 2026 13:05:29 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878q3osmme.fsf@toke.dk>
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
Content-Transfer-Encoding: quoted-printable

Michail Andreas Michalopoulos <mike.michalo@gmail.com> writes:

> ath9k_wmi_rsp_callback() copies cmd_rsp_len bytes from the response
> without checking how many bytes the device sent. A short or empty
> response makes it copy stale bytes from the uninitialised USB REG_IN
> buffer into the caller's buffer, e.g. into the value returned by
> ath9k_regread().
>
> Commit 93ce8ea70451 ("wifi: ath9k: reject short WMI command responses")
> failed such responses with -EMSGSIZE, but AR9271 firmware answers
> commands that return nothing with an empty response, so that broke
> normal operation and was reverted by commit 90201351a862 ("wifi: atk9k:
> Revert "wifi: ath9k: reject short WMI command responses"").
>
> Copy only the bytes that were received and zero the rest of the
> caller's buffer instead. Empty responses keep completing successfully,
> and callers no longer see bytes the device never sent.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
