Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018067;
	b=G5XEJKR6wEqd6ZmvrWSd2jKhPg6/TReE8GY62bFm7/Kh3jNeERbi99lH8Arn/WEEK+fq
	 XQOoYMm5SPiN0mdbvsiXgKVxcs2KByP4h33yHgM0sqHwm5hoT0pYbGnTRO2vdcXsyoCE3
	 matW0GNFRVlZ043Ln0WTp4pXr890lD9iQTIVMwRTxMI/LhpTae6MSmoeSR3of0E9BXqYP
	 lrumy4HMnlZtuHyuN38BAOk5ZUkXUaFTfEY1bdbbbGZj92h8PSQDG9uyOSiH/3uXKYzDV
	 A0fKN/V+cmaI0Q3+JOplSYC7JTLb/WG2p5vSDA7J4M/gF9OdHDiLMRBkG60a36bdMYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
	b=YFKkD+zBqzMXG551HUDDpmh64vr+ytpT12grgFqk94e4d7vGCdOz16j9NaAgsLzdIZVS
	 tmypTvcl893jkO6Bf5xloWEobx/hhhLxoBGdfwvyVZ420esMKjVhXGcMZvgvBgCto9L9E
	 48Orks2uKhMA4RFBtZEWt1445qm7jXCaCUgx8Fk0zf65clsJqj6SYZMIsQK7iT8TIRKWl
	 yFvcAZ3RK1Gm0D0jChCfFUZEJ5neM7QhJEd4hBrUXE9bM5fXJ8+5M6sqtSg4dbOO7WgRJ
	 trvxYIYOefykulwr/iKWJBjNV9ZvrJ5tX5Wc5rSAFkFmLQkUAkKdQB1B6wv8qUqM0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE760A3822
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BE760A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4adf4431ca0so347868fac.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018066; x=1795622866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=rfERdRutCiY1Lz5trk/rT3JitdkQbyeRpy92SAEBTr0SmwHHW7GjbVlsL6xi4GLvlA
         eIy6I8HWFFPJEAko7lPdUqZJ0ASfQs39uGsb2kxFW41b1JV5vmuNw7JyeQ7RyefPZ0K/
         9xQMAXHoHzpNH4wuyizF2fSFPUA4p28V42dt2F4Kqw0BLpetMDyzdYPIEpOPJPmRoJPR
         CA0R4B7acExX6CwARQsZdifC0Die7wBlG1RRQSCl2BNtFRelYwu0NbJSKXPCQplp7vXG
         14ey5H5NU8zd6o0RiLfoiNrrbcb/neM2Pssr4bC/1VTI7DlntKS58QKULJCOW7HRil/c
         C9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018066; x=1795622866;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=A1NZSrgTTOuSvl1PW+jhmA8T4SrxlWR1I0aMnnoxd8yevnKGy35aj9TPISMVg8o/H7
         fUtWnvhYjiWiMSaO33AE0ZdiyLlah3Dxc6VjkkaTvzxjC6T/HuY5ecJwyKsOew4IAul2
         sX0ks77Bw8D0lEmP4mPjuhb0e+icwDUgTdKlL0AhhOTFOp5N2qloiLg165fveXKYfDh2
         IuqJt8q6/2UohgVpC0oC7hyt+J65RgJawGPgchN0paImjC+zr9mf7tYIWbCk281fKW7y
         ktIaog4i3u1yE2NG71ZOgKmmn+YloZz/QGs2kjCVzwsLyvzrrGv+XtdMmsuJqdJOz7eZ
         A0Bw==
X-Forwarded-Encrypted: i=1; AL+hErGquAcinw02IlvfCEu0aXE6toAWvVQqZ6IaQd73CsRvEsXWzEUxEisUS8VdjLu99UDppHjpN3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QXFrQxdbRqgyrMjPB8c8i5k/aprKTWCwQgY3ZCnF4CQ69PytU
	63M/jj0Cke15941CiRn8XgBAVwPQfrY/sRd1inPaGx9xpL/xNme3B94wlPjKJhM1PdM=
X-Gm-Gg: AYBFou1z/VOD5gdunjpuJJcpfkEDHrC1OLBU4Z+Y2mAN7p7RWfKTnCJJS+4ek7KMK/e
	yfrkr9bOTEhI/eOcxsXt4sewvdOryBYd1Mfw3Hwl1IpAP2mVhTlPglC+jmDqJnpDajENZIlacJh
	OqZ9BidEAxkO9wlcRRygst7PCjzqOwGBofYnSATZ7AMJrlVuILdpSveFwMqI4avrIsWx+Ys7tKZ
	4c5FKJoRsP7RF9Bs6wqSgFcayBJGG8zNlYfQd0Eu3eV7pCWIAVoRDpigNXMRdsREr17edrA1qmW
	QoWiH97aqsHBYEEAml+zjMF61Ba7KEZWqYPicijZw5ArITppAkVnXJKCOU6sZAMZCs/2Qe1Kl00
	+mlgYt04mEliCTVNdZiTnua18PD/e5aFn3geu1XFrM3ChnxAMGapVCIl/GhX8UaTOcRY4BOyxrV
	MtZj+Yy4RBFS5YT/Lvip/H4SeOS8/2KLw41BOBiX62WD31ng/JXv2HNphw0Y7pfemmF7m7b+Y/H
	hIsAz58vy5fRTyQjrwCkCw0yBbJ0X+S5VpGQkWzl2lEU3BEMQ4S9YKzjo5K2takJVgrVuiP7giJ
	5OHI912ANudYtHHKT4ydkr9oGT+F6t7yxN6zD0Skp86rZ56DOzKIKGALNdtED2IpQu1BZq/cH3P
	ZxA1uaDaid2/rMDzhqKBfuY4k+jdLoTBXSIdKcq++TioTDHN+4CVgogRYb86ORbW+YbW4PED3
X-Received: by 2002:a05:6870:8920:b0:49d:c8ab:967b with SMTP id 586e51a60fabf-4b7620acf02mr2521246fac.47.1795018065606;
        Wed, 18 Nov 2026 08:07:45 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
 Brian Norris <briannorris@chromium.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>, 
 Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261104112744.1630864-1-stanleyjhu@google.com>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
Message-Id: <179501806424.17649.9429091372346585775.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:44 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 04 Nov 2026 19:27:44 +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), a failed runtime resume leaves
> dev->power.runtime_error at 0 with runtime_status set to RPM_SUSPENDED,
> so later runtime resume requests run sdev_runtime_resume() again:
> 
> 1. A runtime suspend increments q->pm_only from 0 to 1 and sets
>    q->rpm_status to RPM_SUSPENDED.
> 2. The first runtime resume fails in the driver callback, and
>    blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
>    blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
>    commands can enter the queue (intended since
>    commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
>    runtime active in blk_post_runtime_resume()")).
> 3. A retried runtime resume calls blk_pre_runtime_resume(), which
>    overwrites q->rpm_status from RPM_ACTIVE to RPM_RESUMING, so
>    blk_post_runtime_resume() sees old_status != RPM_ACTIVE and calls
>    blk_clear_pm_only() a second time without a matching
>    blk_set_pm_only().
> 4. q->pm_only underflows from 0 to -1 (triggering WARN_ON_ONCE in
>    blk_clear_pm_only()), blocking non-PM requests in blk_queue_enter()
>    and __bio_queue_enter() while the device is RPM_ACTIVE, and the next
>    runtime suspend increments q->pm_only from -1 to 0, letting non-PM
>    requests dispatch while RPM_SUSPENDED. This hits the UFS device
>    well-known LUN by default and SCSI disks with
>    manage_runtime_start_stop enabled (ATA and FireWire sbp2 defaults).
> 
> [...]

Applied, thanks!

[1/1] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active
      commit: 657d7c48b84f2ef0bf885b47cf2318823bc72970

Best regards,
-- 
Jens Axboe



