Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793580304;
	b=y1QfxOYy74Yx9ELpVENu2D8QzY9W3f8PSSLNdJAQ3Tg8PyptfwUY512D83Nw6WO/Jiy0
	 P6UMXMKAWI7/GeUnA7V95JKsCLyYjllVOM2UyISMPrfPn4q5iSFA3IwtZnXnsZKquDtQ8
	 HY74L5DUKGMpg06cCSyav5pxAfotrDKgaC8WfIT8IgurDktH/ogdI+ldGnWgDGYDCNU0E
	 use+G5wigV79lBHfsRWdyRcj/CwhTLwuP/FMNKYRhixFzGd99tmL/0IJ8duhKTqlKmPG2
	 2PJQfBGCON9EIqh5rdNeq4A9/tLGLPG7bmeBORGhXRSJHQDQtXvHpfsfDiMTy7kCQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KgTB+cignjVRgjQLxHLa4kjWTCIUS/wqnaBRjGnD9Jk=;
	b=q2sYJo1XMe7plbuHR2J84G27Q8CbCMudpGzFbHUv18YThgLSTXzPK85myY/pCOZxdzlR
	 ji6mGhU5a13EFP8xUBhvYSU/6xKeJSJjaXMKWQqrqp3Uj0F9LXrL8QPBg+fLIiaNZlVkS
	 C51zbAP+a7K4WNkx3Fxl7+GVxZv+d8UrFrJRbmzrhT7ooK33M0xVQsp6Wpe+RV/SMa1En
	 Me73+3Em9ZG0WUYJu/30ftIu0cPsiKV14ct92YEl2wowWDDwS49EwgIxbpmU4TupxDi71
	 VexC8879rd0A0cHRlb+2K5oKgVP6MX7R2Rlrqxg5iKrkoKOevXuaAlTb1cMfsdSMFKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5mVdzUs;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B663606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 00:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B663606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5mVdzUs
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so5020117eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 16:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793580303; x=1794185103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgTB+cignjVRgjQLxHLa4kjWTCIUS/wqnaBRjGnD9Jk=;
        b=e5mVdzUszWOQ1k0lfWiGZN7UQZO2C5j4Zqn2HgMmKnJtlhdYoUScQCeZLmwWj19Aup
         gdhy1ssuu6zwdYQAz5L8tv/KohMt73cBmyyYXMT1pomVW+rdbFxX7c4gMCzSfIx9Jc7l
         Y1uw+njWLWcD+glz55kQJG3lhKa9KHWZaUSJt4Jja5tUMEDcWc08/kjzwZAvpud6115H
         2PlePqxdytxVNYbtyRqGcK5iCviblwUV7L2evOA6kCovO0yzAOB6BzEDbf1yZe28BCor
         UHTatKhOqQE7ZBpqGunC9DOVBv19w6JyYMvvmiHkXIzBQCvfFr1KPeUozIyFDHhsLw5h
         zitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793580303; x=1794185103;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgTB+cignjVRgjQLxHLa4kjWTCIUS/wqnaBRjGnD9Jk=;
        b=OSGJg7xzI0bmLimFBFfAgSN9Lqj4NBv2qkBO6o+wWwrtxvYm3GT0GGs5RahpcLNhTf
         R+nRqTrybWOKzx7WIlXY38PPMeg1hYK8dzcs6Hs6qb3um+gA2hdZ3XzWx7KV9nHwwTJo
         +airZVldAFQhkRh8V3m+i7CVA6c00Rpp4BeG5irunwGmKqFbBHZy3ZZglNPAsWy8BBGJ
         tT1/0smquwO1DV6/OniWgJ+d5LzkXKNhJ883RtDFztFQVs4nMJc606rrS7Mr+nL6HcK1
         LA6SEG9X45buX3ijolNbs+N7bJSS0VrgsstMgdc1m8SANSgPw6icLvqTcTFNBvH9W7rq
         4QIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2i+WEKOd2p4P6hbOKkvb3yJdugpro8sLwANyHBGArDA2mHxO2dnfDM2IiUHcsqBDE7UDNLHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyTSyRdocM2kgG4Uxv5amYfULRkICz5ACtrD9niCaM1IdoikV+
	ehzu1IRL44C5KxXoH4mGeBe6wrkP8iMzZeczyoW+e7HsJOyljMvbpYd4
X-Gm-Gg: AYBFou2Ddc9HvKECXmeiNksaSNEByxi/anzqGZXGqXi7YTB1NT3wcPO5XuMT/moF86d
	hrKnNbP4qsaI3BceLMW9+wVjH/GjslmIn3AfmWkqi0Q+l2MHhP5IgU4YRWRHUFAwpN/r4kuLcwb
	JvKekwyoqXPfj8imwP2REF8TQQxSmS+nwyEnmm43jWS4WhfgJpH8S2KiQ0bO+LRGSmlbrOfLGMl
	CNCgUtcEqijkS1Kt0g6DOAOxqlsbcF4dAYpkmheWKed+ZKUI4ztu221W0rRPIk0bNabW324rUDd
	lM93iSlKVlv3bcgH5Q3/gY2udmphZqs9p9SnlawbeX0WXU5JFOaxnMvbjdBt2OZCp0mr3VKJMUB
	Rc1ms1fG3Yl00d2P5c+2A3NxpOQeUyvHF8TrzncahY6ORZk/GZSCR+edxuWY2dFkoZzxECXxABt
	OKNZ/ZbWUnfhnoXF3ckbizdr6F1ZOyxUMmYMQb9Jv+NPyBM8WB99LBOSz+tuJJdkEbqv5WQy0VI
	lP1l4dZmFZXLElrbnvmZ6ArYlf2Rvu/Dzh/IKTJamfK4uGNd9Q48SCSk+hUPoyrWVVL7VL+jKi4
	81dwP8Gby/q4cIOgUFlfhAXXNLiXxyBK0wd5cwBfEQsJxr/68RQAHtBuRIv0bZD7snBB+E4czk7
	dwA==
X-Received: by 2002:a05:7022:ef07:b0:188:ea93:6cf9 with SMTP id a92af1059eb24-1ac5eea1fe9mr15602497c88.43.1793580302546;
        Sun, 01 Nov 2026 16:45:02 -0800 (PST)
Received: from [192.168.0.22] ([211.226.54.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm49255251c88.7.2026.11.01.16.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:45:02 -0800 (PST)
Message-ID: <e11a0f9b-e703-4f83-a5e9-cb28c85aadc2@gmail.com>
Date: Mon, 2 Nov 2026 09:44:56 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: mcq: Reap aborted CQEs before returning
 from abort
Content-Language: ko
To: Peter Wang <peter.wang@mediatek.com>, bvanassche@acm.org
Cc: James.Bottomley@HansenPartnership.com, alim.akhtar@samsung.com,
 avri.altman@sandisk.com, beanhuo@micron.com, can.guo@oss.qualcomm.com,
 cw9316.lee@samsung.com, hyenc.jeong@samsung.com, j-young.choi@samsung.com,
 jeuk20.kim@samsung.com, john.garry@linux.dev, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, mkp@kernel.org, ping.gao@samsung.com,
 rafael.j.wysocki@intel.com, stanleyjhu@google.com, vamshigajjela@google.com,
 stable@vger.kernel.org
References: <20261030011321.1868029-1-jeuk20.kim@gmail.com>
 <c6c84b433923fb2c4d332dfd79875be9ebbd1681.camel@mediatek.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <c6c84b433923fb2c4d332dfd79875be9ebbd1681.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/30/2026 5:00 PM, Peter Wang wrote:
>
> On Fri, 2026-10-30 at 10:13 +0900, Jeuk Kim wrote:
> > From: Jeuk Kim <jeuk20.kim@samsung.com>
> > 
> > ufshcd_mcq_abort() can return before the OCS_ABORTED CQE is reaped.
>
> The Initiate Cleanup procedure polls SQ_CUS until the
> MCQ_POLL_US (500000) timeout expires. So is this issue caused by
> the hardware completing the cleanup operation only after the
> timeout had already expired?
>
Hi Peter,

No, this issue can occur even when SQ cleanup completes within the timeout.

SQRTSy.CUS indicates hardware cleanup completion, but it does not
guarantee that the driver has finished processing the OCS_ABORTED CQE.

Before this patch, ufshcd_mcq_abort() could return SUCCESS before CQE
processing completed, allowing the SCSI core to retry or finish the
command.

Thanks,
Jeuk

