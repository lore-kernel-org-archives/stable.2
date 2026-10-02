Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F444C678
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929780; cv=none; b=u9MizXNqVQhTX+xB1nNNmQNn2LOzp7lYfmZfK8VWn0EV516lLkiLgcvqu8F+1KWEQ+imX7Iy9ORGuSNH96h9ZP+a05F7pYKyKkOjEE/kxBdrnbMdGGoCTKLrJQlryD0bFFZRxCasDbcBZ4HAb1E0mLj2Z4VS9xKa2uK5uu8ybeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929780; c=relaxed/simple;
	bh=4fs/VQZKtb98+M3k1wMj9HBBcIArXcqoyONJWXODarI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEMZfyYxd4Z5Yg9D+o1yJmeApl2zMy7Lz4EzTTirnD9t7o8tvZ8iDjBX88QbFGdWxdVqRD/TF934fNfc44KpLlgkgZHrYvTCiB8QSKkk2Lfo7jUQqW3HiCf6kAObhpUSWh2fxKU/7Akx1983wi09knzID4vdIfnfiyDVdHYhptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6Gm9VT3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Gm9VT3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a163f2555aso555115e9.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929777; x=1791534577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HxFyK1o2cNI+UQbuw/QFce5jwNiOPgdR3iM+OqmqoDs=;
        b=p6Gm9VT3VFUcTbQMFn99A2tQcwrShXNDFqwAHoFUfwZkeIxC37ZcuvuF6brPRC65V3
         vqUW5OXP16Qpl4xjMqpchCGHDLlQgr2OGm4DoiVRelacW3Pg/tXtc5GR71fiqjs1CH+7
         hZqt/ddk9fu++gvBYTC7lhGlWiB4suMZa7lbnI6Gfrl+IoFDQKmJ86W177U/cGHTBGJP
         f+9psgxZBJmjXaBAvXxDC5VQWaWEjTYC9e76EZuhOtaRDx1V1o31RIbNqc8EClbWNlMr
         CST6sx2TsCnXwyylmmtEgv58J2YLxvfKp0Mgm3nQYcDQb2c56QvFHDHQL1WDRqFPCS5/
         T7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929777; x=1791534577;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxFyK1o2cNI+UQbuw/QFce5jwNiOPgdR3iM+OqmqoDs=;
        b=1vqEBArRAV245rfBarSqCVG/URdBQyDUmuTRofZN5R/eu2UM+f5pt2DGZLshaRB7Ss
         LV7Pb/7Oqq9ISMynUNsQHX7KSM6RBjwMg1tStl3xH8bwK9lzDvIuwLlvZmTMCQThYSIL
         gTomjOPyzzEYDVK1EXVW3NjqHPdnwl6w6ub7R+n+kurNFzloKP3Rfsjj/1DxlNh6jT39
         ffHHcFBHDyKjt/Ly5nYmbtfxLBVRuEo83g18ydtPV5YonJMCqcAV+htPNNfj/g0j8yj8
         uWgKqxYaqGZxtCDZLZCRSic+9BfVbUe/HzBFLv+NejPFg6jFDrDWAzPDok+qGs04ofP8
         nX6A==
X-Forwarded-Encrypted: i=1; AKwUvBxZmkgJyIiGziuixvXK83zHAqeU3Mr4/dRSlS0kzA4aQ5aJAyAyg6Y/GFpDO1211UcDQ/F40Uk=@vger.kernel.org
X-Gm-Message-State: AFuF++nXuLBRW5WjgcxPa7xaJ9194hjJRk2SSmknvBXN7cz5WSg4j3cG
	NZi2i8morm0EGbfHkP3AOSSd58i2PV9tE9TO/rMVb1AsgpB+cH1B0bbl
X-Gm-Gg: AYBFou3+pWtG6+wpR/3y3WYIRl25I8srrfKFXiPZliU0i0YRNVYc4ZznkCe9jju4PVL
	+vSAjxfkMbwjgQJVYlLmMZ/gDJ1XeQluOvLOyIKz6KIuDVkiN0Wq33uCGMpxuCtlrKhYEtkrWtZ
	qRAV8g9+arbuGNfwHYkW16phJ6BRnUHJcsgEVm3ARXnjpKf0yL2y+C3EfjRXcMhjlX88yU3/bj5
	bjaQmGL+AF4BwQVJeaiDDTlJZ1eLXOWGifh9WLZXT993bg5W5QBwCLwPuB1lfXCcfPtp4/x4qdz
	iz7EvZfjDNf7TlbAC82Gu7J3gHUIBKhIGPh1Ch3OsD0wNExAsHa9XY5NvMhkTvt2/gWZ8cvPW3h
	DSSRCbyxeAx1me4N9nwyoDOCj3Sz+boGVTErLNni3Bvv2k3pb91hJiKGM3QC3ioE+PyqXzKOYYb
	ClMQIOgNmES1dHBQCYGFodv9UBva3J4hBU2y/235q1vyBJOdyqhKqw/VnJzfWhKzuzAKBaXLrL8
	wW00h7jTA==
X-Received: by 2002:a05:600c:19cb:b0:4a0:98c:e082 with SMTP id 5b1f17b1804b1-4a02759fc4cmr37942775e9.13.1790929776330;
        Fri, 02 Oct 2026 01:29:36 -0700 (PDT)
Received: from foxbook (bfj133.neoplus.adsl.tpnet.pl. [83.28.47.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027725c6asm71100105e9.8.2026.10.02.01.29.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Oct 2026 01:29:36 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:29:31 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: wenxiong@linux.ibm.com
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, wenxiong@us.ibm.com, Brian King
 <brking@linux.vnet.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
Message-ID: <20261002102931.3cb06009.michal.pecio@gmail.com>
In-Reply-To: <20261001222527.11742-1-wenxiong@linux.ibm.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 18:25:27 -0400, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Fixes kexec boot. Without a hard reset, some USB chips will fail to
> initialize in a kexec booted kernel.

What exactly happens after kexec?
Why a PCI reset in particular?
Are we sure it's not a bug elsewhere?

Regards,
Michal
