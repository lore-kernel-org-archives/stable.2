Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25651E1A3D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514763; cv=none; b=tOv0zKdgrZmW0YWCUeaNwbegoJ/099gdbezl9sGXro4+Pb41iQZTV0PK2k1jmrVmRW2WoeU2Bz+ElEjyV9MRQ0qXHATn3Y/4zTZCECEI/fmpXtNmqRl5sIvDjIz7OyZL34Z2yJOvgGIJbOUbBnCq+s2+k5Zt4sS9iTxGPrF1Drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514763; c=relaxed/simple;
	bh=5P2ds+udGcfXYGyJBI5x6x0sKL0RIrK8hPYjx4+B9/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvJivFJEai5wEa2LdP/GMdhygtwl/P8/mXqCjqH5LoDZofYO4VTlilxyuBTkLJt7FAt7+xV5q2waCtc2FKLjwk5iqkvC/bSobJfTx2nmLTrsQI4G1VVKpqyrsAoupq8hsDjXvnHAHmM77HTX7fZhvP976rAw0pKc3PH9V8ZGKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXebVhEf; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXebVhEf"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5df34e70a50so978575e0c.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514761; x=1792119561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hli6cl5EueM3Wmc/Onz03qSAHaGrKyC6bL0MwgrBWDM=;
        b=mXebVhEf3lYcqZ8/bS2+QnX8colstMkYqychqUcYdeVnEBxPTbzrYQAs5aV/7p6nkD
         UJ0CkQyZiWb7QgpztO56yFHzPqT8mvSSxTRA5/5vaHlDU19pbryy4QIB/TZyCJYe3yA1
         VkxYc6wskm43ACFP28gPuFAah8ZVo2cb5WyNieaZSXl1lJ1NDBi8XvNMzWQ2DUqMxvAo
         WW4p0tfHJSYwXexBuirqPaFe4hJMnXRAfy5EzbmN/MBB2cQ1a0AS0AYafwX/ObXXdQRq
         +JUMIFzkiCBBKKfbM+PplzcsL9b46YuLbevbjqM/ytQ0LBCLDW0N//uV6GjAWigqr0Rd
         by0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514761; x=1792119561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hli6cl5EueM3Wmc/Onz03qSAHaGrKyC6bL0MwgrBWDM=;
        b=JY99hYVsstCESXpBVUhQ2RSC+rLIhRoAwUP8s5RluZQdwlijfevoGb3nFdyNfSCyN1
         pWwDenjJMiEfaFc5DLf+T3mSUC4A8+1kIQSVmtU5onFRRGyWlEeYlahdWxY79GKPrJ+0
         RX/MjKP3fIeRO86FGD07Unm+Ue3mqKEESUj4BlLu25fexq9Rrmy6GGSShmoTS4cJcka4
         uLBMHNV2gIl/ECGnMgx831VyXgkVtGk5RMbk9XMbtwa3xaWhUdj29TW0QOHDeIjZpsCt
         iCztqgmK9oTL8slMfBHnUrG6uG1aj+nyQe+LKUWDXFGdMqw11ULoFSmqcChCcn3kEDjD
         uQiA==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6q2mmhKGcEu4+hIk6IRX/2msK2L6vHY2J0j1z8Z9Bh1n1Wzv7skjKkXqUTrbtNmhsuwDlRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJblyyS9LxtePq9JPVndW3Ukb3oJs8LNWbFhBytGZrdueQ1YbKI
	2mg+qbTu6Tc8sJEdTMQFw/brJh8l5NdcDZajLMCzFFwS/Rr8u//i78ZBOkyK5rn0XWqtWA==
X-Gm-Gg: AYBFou2eR61mP33/+988fj9wo47jcupkqIubH4hws+DbjwuBs9Oo+7dStP7Aqz2PsB0
	WWyNjwSeravPvlMZtQ7asSxNlSvNaj1NUWCLbWgtMGd46vDCfMouj1YNv8T6ACV1VqtgB2jOZ6k
	E063MbdIu04wPbWJuMIwKGDVHdxJ5rc9+JJsJrn7AWP/fWYnBWUI4Zb0GMnTpUiaBxj80N5LCnk
	kv9YVQs/KF17xknj84P7fxTsCnwMsr/vG5DWDBLkWJvcbwJeNDTHMM1k1yEU0kOvL+lJlzcsQyY
	tkZQRJBePT+xMynFETfi3z5mRMBgh6/kwHAwjc6yKBkaCWK9wLXWqZZ02/prZcR685XU80A6a6D
	IEPzkUbYRB4kRaV5Sg3A94IUTtG5UkqBto2NS9UQxdgQk+cWL/bN6SwMd+gjzlBHmDsjpLs5WbP
	Axa2WxXl+JH+uecamvHLpU3xy/iak30stKDURwAuSy5jpjgDKyz9U9FdjTRZpHx+c=
X-Received: by 2002:a05:6102:452:b0:7ba:7a64:5946 with SMTP id ada2fe7eead31-7cb3a1094c2mr118001137.35.1791514761520;
        Thu, 08 Oct 2026 19:59:21 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f8c0edsm758400241.11.2026.10.08.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:59:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size computation
Date: Thu,  8 Oct 2026 23:58:41 -0300
Message-ID: <20261009025857.3027341-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809002621.122832-1-qwe.aldo@gmail.com>
References: <20260809002621.122832-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave, Gerd,

Friendly ping on this v2, sent August 8.  The original ALLOC_SURF
integer overflow allows a DRM_AUTH client to create a surface backed
by a one-page BO but described to the device as up to 4 GiB.

The v2 computes the size in u64 (addressing a Sashiko review note
about 32-bit wrap on the height+1 addition).

Let me know if it needs any changes.

Thanks,
Aldo
