Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786F19CCF5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570331; cv=none; b=itP/Yj5Xwa+LL8LRY32+u9GduW+0wTcc+Q+n+hm1xyMWloh5YV2Dt2gffJfHimzFqIoQHKQurSm4dJdWxV3lfLNYvTCtfSCUN/0GwTGnwb1H2lT5K03RJ5Mjkd7y9KyQxQkgFHth04DHaaiNZ0abd7y0/c+tNvbrv8+REl4g+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570331; c=relaxed/simple;
	bh=oYMPXUg5FRpTGpq/VChufToWIT8D2XYBNz1jqWQZd14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR/il3OBpQ50ClpqhXYYHqZ2jKOJOj+id/97KQLVNRxjhATiJLcW3aSGHVYGnzQCsJK8UrHcUBJuy0BqUipeFYbvPEt6Src3CyBF2+D5Op9cc11RTxqE6WqbprVZWuQdZt6ym8YUSxUaiIEwPdfbC1RXCzFrdF81JvWMlzzDcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+S9GrTH; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+S9GrTH"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1474c6b7742so932580c88.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790570328; x=1791175128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9YFNOM35bVSfIS9/7AW72GbBEe1YCeVTQopxAj3TL0=;
        b=Q+S9GrTHakmOPeFFNUbWxnb7iokwjTb6dKNPNxocRySVeYxMcySNBHP5pWjMFfqFeI
         T1U3iRA9w5c2Isj9IZeQ/ZMvmxMK0eYpmgbQW6Jpq/mvQkc45mDAnebvBTfG5xnwvLWt
         nFAia4LO2aYxcG/cwwftKzqy1RznYw7grjJ3GAwHISrkG+32oME39aG1suLcC+cnsP3e
         8pCLXvmcix9WlPRnA5Hwx1haoQrW0GqjFM6vNZb3uzy3HMAiq/xmHLbssbRKT1ndq9c6
         +qS50F2g8mvn0rXZIlJOeFImlPbKbq/FnZIrOKRs7kHf9qtGT1dLv6StiEsDCMVzxnmJ
         DVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570328; x=1791175128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9YFNOM35bVSfIS9/7AW72GbBEe1YCeVTQopxAj3TL0=;
        b=dvKB6g9cteh0BoFBiBT57XC8lHAoqsA+c5mouO6JRdAvA46XmMsUZUfYsl8OeU/euH
         Qini9+7b8QkOBsj7xvf9QnOH4VldXKhNkapgeeAMUlUvk6013uMyN5/HT6+QThS3vC1o
         j4/skVCF/WIebvGYMtN2MrSgcYpJ5yfwAHtF0ovlgItwj3mehF54p47N3dc2FNlBnuSu
         q1nTkTgZ6rTnLSSlN462+Pve5Z+Imi191v9KGSWWALm61cpWX7V1ChviH7JNQ273f57M
         wNFH1z4beVdCmmIuRAvIEf67EIKPkyBn5yR3/gEJBXWEyii26E7hCZPgFL/kBQhKHU82
         rKZA==
X-Forwarded-Encrypted: i=1; AKwUvBwOcLM7NG4q/TOCB977C/w4JUKFm7lNXy/AtX8pWNkXbahoe6gISHvQZfaSMZLDaxICVFEi49s=@vger.kernel.org
X-Gm-Message-State: AFuF++nirymJd8HB6vTHd9fqrNihScAXKRYzJ0+MK0tYPJrfdF67Ix0X
	prhw0DS0AMl47iAX7hWc3mCzm2B+VD4LBahaPzjATShALO2wQifKNYmJSTttfMNb
X-Gm-Gg: AYBFou2AXdaY2xm+h0sDzrI4EQn0flwOouAGenKuwfqoX2JKtRTY8ZledHnkeFcjSR6
	4nO6KxjAM67uK3Clbiyh+FqGBY0AUQeUbnELV7feCE1UQWyELUnCuA3zVByyVGuXcL50pweNNFx
	nJWoRuRREgrcVwlwD31hjtIOVq4pqqObo2+E52vB2EtbWj7nCT+Xu/zCJIgtuN1WQ6sONE23VCq
	jbUKUnMU2YTCrKLwWvDE3j+pX6Sj7Q7BevTGZGFCvWHntt0aHlplHYEpmSKPRKfzWXN3hJJTQX5
	kclzfdqCMjf0PD2ejPj/YTRS5OrP03/TFVnD1mpAuvtdBFA0CKI/6qx2XaYdVWI41vzCX3NnvtJ
	43ccATJeKUGMxpUUr7PHMIaNzX7bEUR0phFQTM4Nd6H5Xo3mhSK9TI9Zv6JAqaXvgsxvXnV+wWT
	D8X50hxoqgPtmQOgD+SPxVJ07wQQyfqdGHethxr0J88ScQoZT8bISn+Z4cOkeaBUxQicTqYhL6P
	uuN1cyD1+xoV9DW/ulRi1fq6sxP410Ygw2bFFId+A==
X-Received: by 2002:a05:7022:b048:10b0:144:e658:94f with SMTP id a92af1059eb24-146d0f33db2mr8902859c88.43.1790570328080;
        Sun, 27 Sep 2026 21:38:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm16358758c88.17.2026.09.27.21.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:38:47 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:38:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
	Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: s6sy761 - fix resume ordering and restore
 sensing
Message-ID: <arnvS7Hk7uIKKLrZ@google.com>
References: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>

On Sat, Sep 26, 2026 at 10:26:47PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> System suspend powers the controller off and resume powers it back on,
> but the resume path enables the interrupt before s6sy761_power_on()
> checks the boot. The firmware raises its boot-complete event on the
> interrupt line, the threaded handler consumes it, s6sy761_power_on()
> then reads an empty event and resume fails with -ENODEV, skipping the
> touch function setup:
> 
> s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19
> 
> Power the chip on first and only then unmask the interrupt. Once resume
> completes the boot handshake the chip comes back with sensing off, as
> at probe where input_open() turns it on, so the touchscreen stays dead
> after resume. Send SENSE_ON again when the input device is open.
> 
> Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
> the touch function and sense status match the pre-suspend state.
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thank you.

-- 
Dmitry
