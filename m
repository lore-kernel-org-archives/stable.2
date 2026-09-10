Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFE3D5668
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024900; cv=none; b=EfXupZMBnCLCTwitdCX7WN6XwUQ4VfncO7IH+z/vlX+N3wQy1wkv9udbU1oFrGws7S4QeVIaE4SDPd3yk3esupY2fB2nBuoVPd8FwjOEStjDq+GMdOYrClkwYIb7cmWFwksOaEbSuZT7HViqaijTH49Hot1V9DfEM/JYZ2P5Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024900; c=relaxed/simple;
	bh=iDx9kFP2Pe+5f4NTzgM4UokikspnqAWM6BeY6UMISyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMNYjan4z710Ti7NCqom+moKYaYaevxg500M2AHkPzlQajI9cGAxLPazcEQ0F7MvmNaeRjtOb0USvHgPhanrNoR1x46L/UWXOpydsx2ouhRF68cvgTLXqj2hTXBLrOLzrJaO8PFGx+Y7CHl5U1l7MtFW6HuMADUzDj2LKByTWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2yZ1gnE; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2yZ1gnE"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1187891f8f.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024896; x=1789629696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDx9kFP2Pe+5f4NTzgM4UokikspnqAWM6BeY6UMISyQ=;
        b=o2yZ1gnEhJUCbMBhoiTt9F+IeYNcX97u6YCcTE6EEF0qtzoRa6qpqrrMZl7btTyKVD
         H5VqT0CeE7HcEVZ/G31Wf/fVqR5D3xnj1if/lizghYzzBlsWAXmy8cr3SGtEwjMgVzc3
         1+cYgHz/kaG26HzhSCOwGlhl8xqkz3P5D8czJ5p1ZSUP3kZiSXCNSGpI0g9lGr+GauNQ
         5/LUjTmfjTqpsOFWt7WzFrDc8LgcgEPcVXCecuz//dZBNKg9U5gfYwRDuOhtcH2w9EC0
         xUqXalVAEaOVijJNOFvCGD2fN5ouYqvZgFszcQNeV8rCluzS6kPuOcVpHDbP2DXwj4AD
         plGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024896; x=1789629696;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDx9kFP2Pe+5f4NTzgM4UokikspnqAWM6BeY6UMISyQ=;
        b=HaOZd0BQLsW2JOwtzfyVc9/9e+uc0USx84zAdfZRrpYGbZpcYzZfbX+plDL1DxhZkL
         oFJmb2h0bJZ2A2CX8QTSP/lCs/XRuGQVvFV0vke1OMIp+OR0n8XRM0E0JtUkTu/TaPOJ
         qJObwDjTGP6NlzVMXFf3v3dC4iq0MLONX/4BmviSaK4ErNffMUtWXjncE4W/7ORf9/Ey
         lMFmxPhMtnW3VbovHhbEfTeP7GpZgZQ4qaHGQheI/a2pPAUT9g+kxhpAytqU/CpyesBZ
         nCskoAGoy0LDEo4wY6jhMaBknL9SX2cOrOkICHu7ImQ5B/X/93r5VN9/i7acp07+ADoi
         w6kA==
X-Forwarded-Encrypted: i=1; AKwUvBz+SYRV0Zn7kSE0UOxKNieBMMBEcvauyrOigjvg3i0a1/xgSSXeinFPv2u5GqOihbQNTDFEoRw=@vger.kernel.org
X-Gm-Message-State: AFuF++mEzVCx7rlOjdKnwr7RTSVY3fFq+g92dU3xcxEO7QsA47ULob7Q
	trEKXarYth6fNTgGmBRqJFcgMal5AEVuzK6y5MihaG3R+fKGJ49wC0q9NgZEsokN
X-Gm-Gg: AYBFou2AHuXmtZlbQndb2ohmrcgPni44cW+J62HmJzDOgyqf5FC8XJ7GkhHV7Q4YKnM
	6q0LwJeCiu/f7N5Y0R68BG3t5gAN0ci3db81RMPek3m3qzTfL98H2AaQIfFCwgaykcAPiEu8QRx
	jV3FfkJ0cXMae3LYv/bhokplF558Ghuz0II9qA5njyKLJbLAvqnfQs6+GgxZ7ToW6Ap92QAxxub
	Ph94AHnqwFv6aqrp2+iJT4fXDzNWKGPQJ5Yh4AnMqD4CB8b6N/8eM7OaXVdxe3LGininFeJYbIw
	39jc5NEGnM/FH7sn3uiQj/7wSYtpuiRuwtrFKD1hobHKHIBgkSyiJ1eD+6saHM0CEAc89AZMq4M
	Vh+1rAraAm92qNfdcXaUnZDSxEMYZFLUsmdfe0fKxaFR2nES3xt+TTCRo2C7zX0EUy1En12mqCI
	Ho5lG/MpjeEDLEUMhe5Wx83i1xxmjfULkkXNZvyYIkbirkWDKnTAlKorju5uxF7Zov5faqzpc/k
	EwfyyXL9/0EXr4=
X-Received: by 2002:a05:6000:1883:b0:482:ea08:8c97 with SMTP id ffacd0b85a97d-485aad9458dmr19032504f8f.2.1789024896166;
        Thu, 10 Sep 2026 00:21:36 -0700 (PDT)
Received: from andreayoga.localdomain ([31.189.90.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm43293768f8f.2.2026.09.10.00.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:21:35 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:21:32 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hrtimer: Use hard expiry when updating timers on the
 same base
Message-ID: <aqJafE8azJ3TWLGT@andreayoga.localdomain>
References: <20260909102749.7677-1-parri.andrea@gmail.com>
 <87v78eza1x.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v78eza1x.ffs@fw13>

> So this really wants to have a big fat comment explaining why this is
> safe to do.

Agreed. The existing comment only describes the update and misses the
temporary tree inconsistency. I'll spell out that the base lock excludes
other queue operations, that the neighbour check proves the node can
remain in place, and that removal does not consult the expiry otherwise.

Thanks,
Andrea
