Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8974F85B0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571268; cv=none; b=t3UWc+ESuAcCvUGBiQzX4LwgDweiIWGKW+UczapS56IP6c3w4R5Wh0YNSS/xtuVRGs+LJwUHDo2bDrCJsLfCmFGG5F+W1yHLu7zqjs44aOvE+LCOVYo8KRgG4dedD+MEzTJDTC5LDC8xXDH2ZuIv96TE7xoSNEDQ5y6mBub7fdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571268; c=relaxed/simple;
	bh=YANs3wQmiPKZOnM/NXs3Y3IF1HigPG6bBSIqF0sVvSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNXD8ctV74UKzIMPA6cq332cGMM8uT5xrTG+JwY8zo0pFRkNBalYa/3WWQF6BNwoMQelRasecH0sL5kZ+D7exptOoOqGWM99j3gCvOzRLatAF/4+7zTzoI+kXzpY77ACHKJG4+n1//j3/mQiJCxmec0msbXUVHBlSDt0Z5Vrm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=tKYwrXRU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="tKYwrXRU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381b831d535so6912297a91.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791571263; x=1792176063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zSZLoNmFFWIsOAx+hwoTbAwrWW/U2t6L9bJl8Gumbo=;
        b=tKYwrXRUNjDwLCc2KeLPnUN3iPUJJ4qSmDlQBFEV0rZy0WWg+yGQODgYWTAcF68xP6
         rZkl1eZvu8hlM/470nwuz9dJjnUvzSQY2OTwQd8vl+oYbPbqWTsO9DrR1scz2zSkDIWD
         pMjR0mBc4sYSUoBpvjmrR9ahH8k8sZzh74dEgyB49FDxf18pPUvUcyv/bsNjkJAOGjct
         5aQ8lwRSCkehS3G38z8T9BE4JaBAsLp1r/1PwI5+aA/ScG+0HauC7Nf0gssT+dqTSqpD
         OqFNDXhENWX/jpqEZ3Ac5Z83RbipOJL7Xjm3nRTS4Pdpk1gcum0EDOL5uJHQH6uuojhp
         buNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571263; x=1792176063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+zSZLoNmFFWIsOAx+hwoTbAwrWW/U2t6L9bJl8Gumbo=;
        b=DNwndbIxu39EKKVfCni3t/ClyOuaD1LzqlF/jXQoY5SKTK0Z39qqyNyJeCTGM0sbbI
         7PIHZ9Cjc2msf6fQnR33QXUtJjRs2ebz6v5Viyc7SgzCt5Sj5mCACjBf+P9jLEBfwpEv
         F/t2iMsxI0hVh1OyX6BB/jT/eRGbpCLyyBulU9qaC3VUmo63PPrFD8KNDF50p1eOfQmd
         l3pj05Ect+jBWKI3wcdAnQyaqGlswDnzZ1AUm3tHBDqVvEg+ZeaW09LRcY5mrhXC7eYZ
         ELqWVGCXb9oLHAbsw18/zCPeII8KCE7e8g9CyeLQCOB3lBI6hqDv6JeuE/w4+q9Mltz5
         pzQw==
X-Forwarded-Encrypted: i=1; AKwUvBx45LECCEMM4A/sPWBTr8sXCVj+0cU458C7f64/2K5LVzuAZPk4Pfeft65PRf546HCf8wE+S9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7hlIIDcnbYuxZOv3BNx1B/oU0yI5s0CmgDPe58R6BmNN5Rb2Z
	ZlCxPBiwCyoh31iE+XUli6jNXu/MQDXB3l7Oo7p12KPH9yImgLxd695j8YismCP0MPo=
X-Gm-Gg: AYBFou3AhCpSpMB8cDTmJKrzUqrCi0AojSgeKFTMrujL1pKpuILK5cMyCmM9C2Wh+NM
	0jSvxGxJW0KXBvxsaVszajwopXDkQ/hWQoY5KHGkSZ3qK2a3YgaK5J00imhvaQWLjwKmVDCkzkp
	ZU/xGv6ICsV++RTlkQLnRnphlaDjuXHaZuecCcLUOkzyUTR/WzSc7F9wzCBqaHE5cL6tQTCUYfd
	w24kbnkTXwse8NzgibQZLlSb9MAQsIRw8LWs+756ofVOYq+1+fw0b6r8+r40LY0mcO705hrTV2/
	sXzClINtXjGwjgqRlPZIPi4MWj5PkgbiP9tiPzJYg+ld4dgCnAhDFU28e7DdO/04z11M3+6iYYp
	uGyxtih+YNU8cGE2/YVdQTEYs3B8PUad7pqaZQ+euwAD+HHKmx4dGG9GNpCp91vJe2/u6cyR3Mx
	0Le9EGPRqbTDtUC8AGFka/RSCIHUFbPiabqeMi6ztZ9aH9z5OIPKR0XYHuTHXTAkEU1QC5GXW1O
	WI3AS2UQSYoSKClpcrSKA==
X-Received: by 2002:a17:90b:1dd1:b0:3a8:bb56:f1ed with SMTP id 98e67ed59e1d1-3ab3acf313fmr2482096a91.50.1791571262758;
        Fri, 09 Oct 2026 11:41:02 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c95f:28ac:324a:cdc3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e08c89sm1485211a12.8.2026.10.09.11.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:02 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Daniel Zahka <daniel.zahka@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	daskald@meta.com,
	mohsin.bashr@gmail.com,
	bobbyeshleman@meta.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net] eth: fbnic: validate the Rx completion buffer index
Date: Sat, 10 Oct 2026 03:40:41 +0900
Message-ID: <20261009184041.1604456-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DM0IFYXERNG1.2ZNS2EYUGGPOF@gmail.com>
References: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr> <DM0IFYXERNG1.2ZNS2EYUGGPOF@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri Oct 9, 2026 at 2:14 PM EDT, Daniel Zahka wrote:
> How exactly are you injecting the completion? Just overwriting the id
> field in the Rx completion with an arbitrary value from the driver?

Yes.  No emulated fbnic, so this isn't from real hardware: on a KASAN
build I ran the completion handlers with FBNIC_RCD_AL_BUFF_PAGE_MASK set
out of range and saw the out-of-bounds access, which the patch removes.
Found by reading the code, not from a report.

> The buffer id is chosen by SW when the BD is submitted to the device,
> and the device just echoes it back like a cookie when that buffer is
> used.

Agreed, a conforming device stays in range: fbnic_bd_prep() puts the
ring slot i, already masked to size_mask in fbnic_fill_bdq(), into
FBNIC_BD_PAGE_ID_MASK, and rx_buf[i] is that slot, so every id the
driver hands out is in range by construction.

The completion path is the one place that takes the id back and uses it
as the rx_buf[] subscript without bounding it.  A device that returns an
id it was never given then gets an out-of-bounds pagecnt_bias decrement
and an out-of-bounds netmem dereference: a device-triggered memory
safety bug, just not one a conforming device reaches.  The patch bounds
the index and drops the frame for one comparison per completion.
