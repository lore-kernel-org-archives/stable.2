Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDD43F4A2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752973; cv=none; b=n19ndEiHtJrtsLALDnywXSZRYvefJUrImplBwhiLhWHrOHxATdvIF6i9aLqAXH/5Rnp+7maB6ggDaQQpLzrTUV8jI1RFVNnaBR7Lu+wV5u1Mgf21UlbdQgXCuHuPvHejqqztk3gk1YS39uSrwr+ZmoPJcZuUXlctVD921KPlgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752973; c=relaxed/simple;
	bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+X1wvz1ziZGZrvnTB+fvzbdeL588nUC0LNCGcXoMon3Fd6poqTRXcE3bKiMqfEHcny1LtXyVVdcROrVjhpBJ7lPnf/qvuBPZOMTnzhnJgJ5DxoswBgmhww5A/RRMExJ3+Mc1B2Hs1jHq7nv7yXyJ0tibZTZrjCTL4n4cyoR/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEICMtTt; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEICMtTt"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso3229000a91.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752972; x=1791357772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=CEICMtTttVfLi9+k2c16ydDJ8mWbdF/GDSH0RsLpUd1HgBCQbLCwsoa/vLZkKhjgr/
         W12EonsHLD5NOkOwWq3t5jVfZqnd4aZzZH2AEyLrfbW8HwliMKBcKl1aihbPHIUG3to/
         M54Ms+nRiSHOq983WBlnqRnOkma3PiUgfc/JDCdVBq4wpTbFpYc/k/eU3wDpfmhJZrbs
         uLYVZ7nbaXX4NoEIVMuIz79aOS/rNoso3ao/Y1LZFZlvJ8gjCLoQxUPNVOwaDxNY//iw
         BVLuwX0Rq4LUgcuvHvYLf5bZrgN/PTCpzRuZpvEJOu4pnifo4EkDnswEpQtVxQD/f/Li
         NUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752972; x=1791357772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=MBkMbvAW4ALSe+Bjo+vnW9iLtXTveGbu05jzX9TeIj7bWQBLWzhWtib/Y6NFDjXW99
         qZbesq8PQI467my2sNuv5r3ZJmEjErQaEpiGz8usDMAnVSsK1bopVExLK3ATGNwXxfHk
         U/iKzqKN42L7MPT1jy9aMllqwlHBdVJYLDTYjJbHfxwLK1y13LqsOWiHwGdgkkpGkxna
         dhI3oKuX7Z8wz1dydgnWOy/1gaUL90XuE2ZDVv2XVNingg6fAWh0jwqxjvA9/2YVuotp
         fg2uyRwzWn6YV1vLlaAtVhxgi2+YHYRusQpCN7vE41WVR4LOaz4C5zC88g9lZ//sZX1F
         v5hg==
X-Forwarded-Encrypted: i=1; AKwUvBzjZDcX2w2VsJe0AkMBSB0Ol7Y4Nbt7LKBCV9coj0RABfNDSz0J0P4+P/GYbB2HRS7Hm9uC4/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbLCfVQrwauYOtnjdVTqVuo7Oolzs624Is5SKFc6dZUkbKI4EC
	34THWlSI5aE1EbkFlrUgQgzEvzV3pAK1C5rQmsGARKhca7dnAnCMJ1T/
X-Gm-Gg: AYBFou20LhF8VUFXVxWhRE/uZWG5cQXGOTNLLySrH3XKVijr71HLQJJZuPZfZSK6NOo
	9uaq2N6qD3G891LJNbUALwQwe87cgyqawxJGysZvkh8uk2qTETrT+D0ysHaxtzM17X443avV/1c
	q7GrRODavzCyXrN6jXeJBA7U69A1GrrU0piYe0BoNfXcy9CwHBhAHfXrF3iPrJ7+7jJTGWpDZEM
	sx7uUG/mv3ESXXZF4fmY+p7mQ35BUcOEXoT1pNO/hvB+jmNgeMpw3M0oVqADLckTcSpXeXir/pa
	FF10oLExe8e9f2TZTS/HiCTBaRflvOifntbK9nFC4/BSKN2DBidOOnTX3ueZrsrANux+secUcJ1
	jJIiJdkCoCRpWOBukkb5Cz0mVEaPmChc3WKCLuqDMOccPGR8FXIUQRXUfQE9lu4oJ/cAJojOVk1
	oWXufa/T4n54dmrEP9V85O3AD64GN2FptPympuxBO4JuydbHDSATEPS7rOtlTNo/faeuXQVo8c4
	vNaU10ynaOtkUuGd7zL8oJ8+r+MPefV1LCJXOoE6m7CIzduLRajTgg6XUQk/alofXKVYy371w3p
	1UuHu37Gnc+UPq3gcm16ry+dr5vyiedGWK/rksWYpfq1nQDqQeWZ/lIU140=
X-Received: by 2002:a17:90b:4ccb:b0:3a0:3a3e:f78d with SMTP id 98e67ed59e1d1-3a4d18cba19mr522044a91.47.1790752972125;
        Wed, 30 Sep 2026 00:22:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c75fcda5sm936078a91.4.2026.09.30.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:51 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/6] qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
Date: Wed, 30 Sep 2026 15:22:49 +0800
Message-ID: <20260930072249.1167653-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-2-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
