Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD723CAA3C
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475150; cv=none; b=CVjJYVP+jbeRDcjTFnnmMhTpexMCa2rSli+Hephs2gF6FG4yV9QteDyyJ4kTFfxEMf5lh7mIiAvJSi/I4FBL82sy2ctBLIY6gGPxHapK7d0oOmLYLyn3oJpVs4Rvaa/rqj6c6udLTaMvHRqORQ0Ip186zV7uMsZE9SnB2oJ7iiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475150; c=relaxed/simple;
	bh=TSGU6OJ0h4fUfeq573U3yF+hws662Cowi5xUNxY/Plc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaJ+Lvxmn/Ddbsd1Ego7xBuoYrfYgAaATxoQOU7iS7JHavPOKMhffqzqiDqCejkUaF0PtLucH2OvPajdCxNjv0QY+AfylmiWOQIvhi2vP9AwaQUd9OLTQHfB1wcR1YCx9FmFfYW9j/mpEkjgB+RRDOIDE2KhHLX74PHFv0NGMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yp8lsIWW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yp8lsIWW"
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 295343F442
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789475145;
	bh=OWz2Oh+f3I45WPvVMwnriAaMSjFo7OhzWowmJMieGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Yp8lsIWWV5r/jk8wC5l3ns4glaXn1V7ailoRvVoygRt5YgPYNFMFzi1fpyZcM4pcN
	 OGWv1N3u8SETrNTKbwJIspLVWZAHhl5wOURtL79VGOvgN5INb0Bf9pu1vAumfjTqIg
	 M6cwPFZ94UQhFSwjtK537WPgnFD1PIWFWcN4vY5DitDtVo+QP7jHmbX3jzjjn7bTMf
	 2wcA0zY0tPlc9PJoS6t0RLv1LoXiZGuIwvESeE3cKiWv0GgnjEIeRXUAKB/ONGjZ2N
	 jc8umcnc+qR4AfcWx2jDOoObiTuaexsRaYkI5CWTm8RvWGABgs8nKsSeTSFwy8jt7e
	 SzjGQqPUHi7skt0owxiwb+Dwhz8dP6iui7LtOZx5D8JWEHiOVMpKJySKUCP8evgm5+
	 Cv8/JW718vjFgwjaNqhZiMCmMH5SbKBD29yeaP3DOVhoaImKzX7BP/2JnkD4Qxob9z
	 +2yLzzy44Kd+8IWqvdhHyERWte+zRmFn9XBGa+o0gPQUvjKqoKATaNW5ZhysSgoRsd
	 yQbLC+wGBmfbqvknGsdFj9LK+Ipui1hGXUeynHfrRi0ypiUTmkEglLw9HKYn6DBPtB
	 R9QsZScim/GiadeJLHk0szOBb8C7UoWADs3doNqZwWnURwrYvHX67eSwua/jASUCKq
	 hIyJaf35uyti1xTIyYPbV7K0=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8688139460bso4304099b3a.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475143; x=1790079943;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWz2Oh+f3I45WPvVMwnriAaMSjFo7OhzWowmJMieGyI=;
        b=C6dKlrR1Mi3Bn0+U3vKOZxr3Rdi/U8Sgu1KNqfM+hE3uSR2OKmn1/UL87OR/p9D8u1
         8YIPTKvbA8P7COshI0Y+Ir3aPwSp4yByxiBAtv9V2QNdxKJAJQ3ta9Rcx74Skq9vyp88
         59DaxKPe0tvUsyW6dZlvkSLcwHtzCOBRRaMaMtKmOLK9e4L9o9UBlMazNDfFTByunco9
         syW4Vh29siUasMdHa7/9K18z37GMTjUbRm2m5RzkEJvJNyuojKVHUriPuMQ748cABrpX
         QKdJHZ3tqfZ4Iq8n0qJXe2K29UeUmGlaK5k29m5ITUEU+bTjieYcTm/+/M2Ax/PQ11ac
         lp+g==
X-Forwarded-Encrypted: i=1; AKwUvByJmwQKXLnhmIfyC8M/vNZh9t8wQMNMgrnc3zSgdDOyf8TjoopvraGwFe8iHnHC5wVSin3pYxk=@vger.kernel.org
X-Gm-Message-State: AFuF++naAle4WfPluBH3I6yiZm9ktaA7f59hZBKaAsdjBVxwDrHI6PvD
	AUHSz+7kDpEeZbPgrFwtr7StOwLjjcAPxwb/K+SksVK1QwWmgH7CkDZITnulBPCcAG39HNcvFKQ
	9rluEqj5xHdLWHrDAKby2m2ZHsoOC9SzLzwGwI3NqcMdeMABYjD4/Xi31xPY25KqlUyKCYELTYQ
	==
X-Gm-Gg: AYBFou3OL/TRb1Kkp6urtVlJujXjB32cQhMu8/YLVkBHbZJAOaL/SKTg+yE0SimFDFN
	TZyDB97QndzIFUsHfCqPpVRQ09fkHMskG/s6YJEFWdz7jn9v179j25Eck8g80g0BHZMTpAPuwrF
	KJ90IezVlUa9ErBfJnXTN0Msirg4e3bZjCJA35KLHwJaXySCynrgzmKAihM1RxtI/r25PFCkBW8
	HK1rKbhIzIsLr5Wg4fPu4hb9xFj+WVCqIZypN3+5skAJgRGhD5Mme3LLxDOnLpMBZH+kwFm7GxM
	oJdgB+TuiYXIifTZIrwpwHReQv6jc7yAnSEwJhS1ll+aa/LiaK/vURgmZB9K8HUKAWkZ/65qxml
	nDcRdD0zJcLjO2tpc89jwCwPFliUaxjSWY+9pxY6DsS8rcZeYEJwP
X-Received: by 2002:a05:6a00:4c9c:b0:85f:b00b:8760 with SMTP id d2e1a72fcca58-86f82a5efbamr14761135b3a.5.1789475143128;
        Tue, 15 Sep 2026 05:25:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c9c:b0:85f:b00b:8760 with SMTP id d2e1a72fcca58-86f82a5efbamr14761047b3a.5.1789475142601;
        Tue, 15 Sep 2026 05:25:42 -0700 (PDT)
Received: from acelan-Precision-5480 (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b28fc129csm6022017b3a.25.2026.09.15.05.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:25:42 -0700 (PDT)
Date: Tue, 15 Sep 2026 20:25:37 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Shyam-sundar.S-k@amd.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, Daniel Gibson <daniel@gibson.sh>, stable@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd: Stop counting intermediate cycles with
 metrics table
Message-ID: <aqk464fQ6JqlcCUX@acelan-Precision-5480>
References: <20260914141734.2703545-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914141734.2703545-1-mario.limonciello@amd.com>

On Mon, Sep 14, 2026 at 09:17:32AM -0500, Mario Limonciello wrote:
> The metrics table doesn't increment for all cases that can cause an
> intermediate wakeup if the cycle is very fast.  This can make the intent
> from commit 9f5595d5f03fd ("platform/x86/amd: pmc: Require at least 2.5
> seconds between HW sleep cycles") not work properly.
>
> That commit originally was measured to work properly, but it was
> accidental due to a logic error.  The logic error was fixed in
> commit 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at
> start of cycle") but this now masked the table doesn't always update.
>
> Since that code was introduced, Daniel Gibson added a number of changes
> to the logic which includes a state variable introduced in
> commit 037f0b03c663a ("platform/x86/amd/pmc: Don't log during
> intermediate wakeups").
>
> Utilize that state variable to instead decide if a single sequence has
> started.
This patch fixes my resume issue with TB4 dock.
Thanks.

Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

>
> Cc: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org # 7.1.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
> Cc: stable@vger.kernel.org # 6.18.y: 037f0b03c663a platform/x86/amd/pmc: Don't log during intermediate wakeups
> Fixes: 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at start of cycle")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6792aa2c61874..e384b56d67559 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -701,19 +701,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  	return rc;
>  }
>
> -static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
> -{
> -	/*
> -	 * Starting a new HW sleep cycle right after waking from one
> -	 * can cause electrical problems triggering the over voltage protection.
> -	 * That is avoided by delaying the next suspend a bit, see also
> -	 * https://lore.kernel.org/all/20250414162446.3853194-1-superm1@kernel.org/
> -	 */
> -	struct smu_metrics table;
> -
> -	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
> -}
> -
>  static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>  {
>  	/*
> @@ -804,7 +791,7 @@ static void amd_pmc_s2idle_check(void)
>  	struct amd_pmc_dev *pdev = &pmc;
>  	int rc;
>
> -	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
> +	if (!pdev->is_first_check_after_suspend ||
>  	    amd_pmc_want_suspend_delay(pdev))
>  		msleep(2500);
>
> --
> 2.43.0
>
