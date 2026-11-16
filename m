Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830455;
	b=ufubUY9JpxWWmCl4NP9D6cOr7QseNPiIX68XbqD77XIocyoypd6eU/ATKyn1fRmLHuFs
	 +vgf6ov3/5VwFOCWzDxlDo0uA9XZW2kL5SYJyhZH+hSJ9qbX5lYh50AGpSM81BPwmgqpS
	 +a/5oh3D3zJEBMQH3z9Smn4UKN84RLkLT0eNhz9s8isZtFl4mefN+TaIRogICBqeP9y/N
	 1B/hJkDI0NnX3ZfmuT9VDem/AbhazbAaOXUgmkn0+HO0JAIEwGPY8A3NF/omcZM/R3Aqp
	 GSQpAIHLMQiGbVMz4+YVwQMYQADlB1TQsNepOFRSGDN3mdUIQCrTBF2xmDyXK+/BSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7GrrfPTtSiFf3eqOfS5BMereeBw05VZ56XZNeLfVvKc=;
	b=YNfYJI/ObcJtHTOmR83NmyHonPoI/p2dGoNAAMIg8Awkx3HOudlCo04+WEHa6Ejpbwlt
	 cJWbvuHC6zU1ucttWwBsLm4+AUxsXDnVrqK6018Lr5WdWRay7czhDCjEw3T86oGKtdVp8
	 mrNZslL5kXWBcfngHV1fyYLejvsDSakFMkmJl61S6miLYkIsTqUPv2qQvl41A0rnNbRhH
	 hG6juSwsvoFI+wHZQ1WAToA4jZxfofLa2n2UJu9RO7HceT9Q4oIId32w6d7/cbtlFVA0x
	 rZbJxfDqe7sQOdGOLYgLfsg9T8MgBfMIRLPKrrwTxvBAIQUHxxO+MzeTipPdE/SdOaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OJ1T4FZP;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC59606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OJ1T4FZP
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso18746175e9.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794830452; x=1795435252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7GrrfPTtSiFf3eqOfS5BMereeBw05VZ56XZNeLfVvKc=;
        b=OJ1T4FZPLnEjhpZLRMscVm6TOrD714DlttVfFF9Pcqur0ovOiJigLjAYbysaNsYEhK
         p0Cp4RLKGHi8p3EUmd4ZHBMhfUTeJpXA/HArJL0ahopo5ab/POfIaNcD8vAp/m8vRlMQ
         v8lhaheuFY6Bg8YyyeDyH6SQ8pe3+LnMZXkkR1x5E0z0FTfM+IytG9vEF5PjnrwL1GIq
         jrgM0IC+/j7kCK+wk//bKWutt5fJeR18H44UYjA76NrmI4pOa2ccQwnbSOChGpTjPS5Y
         zPlEjiX6SQ60rRpFgCBbkt1UTKi1z+WkitWjT2RjYz9pKGbfX8vvWW31msbJDdu4o4vY
         96Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830452; x=1795435252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GrrfPTtSiFf3eqOfS5BMereeBw05VZ56XZNeLfVvKc=;
        b=O3r5Mvk8vjrkS/P8ouWRhp+iv94UVnWfxvRH4ArzWJiZCewPJh/Q3XNNOLdfYmxtA3
         reXYOdXEh+ouJvoTlioW8RQem9IsbtEmP41yUhfKjd3XqBIS8U46Kny4ev4MybLezHxd
         esPvtu+wOaaqwOodQM0cWPbv00qOGJKhm7JqK2dnEKj1OqEidXH+oO4GKYl+e+Uo1to6
         exMppHAb5hRPQotcG2nVr2NhHG+FG5cC3LLdShF/uI2ns4yLUYAn4I8ifQsuIBu8BZqi
         5dcZNxJ+BzONdCPiv42m0yTCEzKeIgzqwqRaf5VuiNOACDU8pV6JmdWRjEdyyBCRh5PX
         rS8g==
X-Forwarded-Encrypted: i=1; AL+hErH5Xe1giVCJxTc8uvFV/Z4M5QMbeA9HFzk4O/pvsM0e0ZXLxt5rldShWPVZEHU5HdKEPgrTL5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8phM2jxtrfye8v67f59sJm3MYul61jzvOCuk2rAkQ+VYkQFiYV
	4CcWoCUxuePTcJfyrdpL6gD8Y/OlB9PwzI2FadLLLmFJ6BUz+6aHLmgeIXWbhb5RzX4=
X-Gm-Gg: AYBFou0ucqQ2Tt7pq5zCvJAsGt9Qgwtazr49vvmndfDuSyhTCeiUS5b6WJmBJVBSZyI
	SR7Xp7+Mo35qMYUwoL7R5nI8aV8CEVkSKOlaEKj11IBLBssZ5mbX+heF7DcYUxDWlbCEDrIz+AH
	mMFdRacDb3BJntNWuyBuorBEQ/WMzh8lATr7wIGqryd3zUj3czlQyKO2fUNtQ0iQ70ACQr9+iIA
	Z+mGAopjsybU8Gxyd5VGj7irl+RXI4HnJqvsCuOqjiUSWvd/XviwmQMIT2R+bWkDXEzyM+uossa
	f4MOgcsrWwLV5UcFY/VVagsYX6H8y1CBNGskq0MOKf0+lU9lpbhNkOXUzDQEgRpjUtAe22erBjn
	dBi15cGDgJl+28m3/p2Vnb9QyJF8VTkTEZII1W1ORwJCeYYF7u1yigdZvV2YO2G4KyIm3/akEDg
	JzV0pm81KZdzh01g+07lLkaLsvaDZi8sjsS8jMmdgeoAXVb/EDQVJ0dp/bFykoKf/zjeEmOrTYx
	gbA74qzyadGOCqGca/y6dhWH7TgKqB1r/Rafv1Ofuocj5zXPn7uMfvf1/HjAJFNd0gHydfK/YDP
	QNiuuslUFo260xmzOVvWmKT3RDZhVI5YZ1gD7P1596eg82E9ZZfK/iXIvmnlQRPrn2rrR6m1
X-Received: by 2002:a05:600c:b86:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb55a67c61mr228790365e9.26.1794830452167;
        Mon, 16 Nov 2026 04:00:52 -0800 (PST)
Received: from ?IPV6:2001:a61:13bb:d801:1801:5442:bbc8:29a9? ([2001:a61:13bb:d801:1801:5442:bbc8:29a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f6a40sm110447535e9.2.2026.11.16.04.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 04:00:51 -0800 (PST)
Message-ID: <69bbe579-d296-4bef-bd0f-da30f12b466f@suse.com>
Date: Mon, 16 Nov 2026 13:00:50 +0100
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
Subject: Re: [PATCH v4] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 usb-storage@lists.one-eyed-alien.net, stable@vger.kernel.org
References: <20261114174929.53871-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261114174929.53871-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.11.26 18:49, Olivier Kaloudoff wrote:
> The ASMedia chip detection in uas_use_uas_driver() assumes that every
> device with idVendor/idProduct 174c:5106 or 174c:55aa reporting a
> config.MaxPower of 0 is an ASM1153 with working UAS.
> 
> ASMT135x bridges (iProduct "ASMT135x") share the same 174c:55aa id and
> also report MaxPower == 0, so they take the "ASM1153, do nothing"
> path — but their UAS implementation is broken:
> 
> - The first READ(16) issued by sd probing times out after 30 s;
>    enumeration only completes after a uas_eh_abort_handler plus a full
>    uas_eh_host_reset_handler cycle:
> 
>      scsi 3:0:0:0: Direct-Access  ASMT     ASMT135x        0  PQ: 0 ANSI: 6
>      sd 3:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
>      sd 3:0:0:0: [sdb] tag#26 CDB: Read(16) 88 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>      scsi host3: uas_eh_host_reset_handler start
>      usb 6-2: reset SuperSpeed USB device number 2 using xhci_hcd
>      scsi host3: uas_eh_host_reset_handler success
> 
> - Under concurrent load the bridge stalls: all inflight commands (20+
>    UAS tags in the captured incident, mixed READ(16)/WRITE(16)) hit the
>    30 s UAS timeout in the same event, forcing repeated abort/reset
>    cycles and eventually a USB disconnect.  Writes dropped mid-flight
>    during these resets returned zeros to the filesystem (observed as
>    XFS metadata corruption on the mounted volume).
> 
> - Sequential-write throughput is ~45 MiB/s under UAS versus ~136 MiB/s
>    after disabling UAS (usb-storage BOT mode), which is fully stable:
>    several tens of GiB written without a single error.
> 
> - Bulk reads of healthy LBA ranges do work under UAS (~190 MiB/s, no
>    errors); the failure pattern is command-timeout at enumeration and
>    under queue depth / write load, not a broken transfer path.
> 
> An extended soak was also run at maintainer request: the device was
> rebound to uas and pushed with ~640 GiB of mixed I/O over ~2h45
> (randrw/seqwrite at queue depths 8-32, disk util ~100%).  Result: zero
> uas_eh events; the queue-depth wedge did not reproduce on demand.  The
> enumeration stall did reproduce once more at the first UAS probe and
> self-recovered via host reset.  Per the maintainer, an inconclusive
> load test still warrants the blacklist given the filesystem-loss risk.
> 
> Since 174c:55aa is shared across several ASMedia bridges and enclosure
> rebrandings, distinguish the ASMT135x by its product string — the same
> approach used for the HIKSEMI MD202 check a few lines below.  The
> product strings of working bridges using the same id ("ASM1053E",
> "ASM1153", "ASM1153E", "ASM1351", vendor rebrands such as "YZWY_TECH")
> do not contain "ASMT135", so the match is safe.
> 
> Verified on an ORICO C10 enclosure (iManufacturer "ASMT", iProduct
> "ASMT135x", bcdDevice 1.00, stock firmware) attached through an Alpine
> Ridge TB3 dock: with the equivalent usb-storage quirks parameter
> (174c:55aa:u) the device is completely stable.
> 
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>Acked-by: Oliver Neukum <oneukum@suse.com>
