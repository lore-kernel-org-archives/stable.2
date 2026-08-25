Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A243FDBF5
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656518; cv=none; b=DRds9SBxe6vpaeYAM1SAou6XGa6KOKfCpUEQNOEmTmQPDR/ug60ZcTY6dDyM3rq+hBsWo31HuvlEQvyZlUKpf2ioEFgNgRHzyqB3ru5954sf1rOqrMIb6rmpXa5WDgZGZf/xEyEUWBhmDD9eifkrddxCQ7slRfHPHI/QoX8D1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656518; c=relaxed/simple;
	bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvuox3+/tmReiyOrGHMW/oMAa6FzVs3+L7mPYUYoEG6FOmrUzNtsa38+GGNzrRnxhOwoOmEfWLWzcNwlr0Dz7f0brnmLrS01a0sxqwXOYXvqURGelAA++JxHTqvWWHIgzzXQHAgilljtL7WLKx0K9ZwL4sPVY7YnWjwpbN3lnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMktEPZE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMktEPZE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-395cf2535acso820818a91.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787656517; x=1788261317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
        b=HMktEPZERGupv1Sa3dsMl7Pkj3eIvvaB7Qmt2XPUQGcA8Jk0M9hdbYGbd4NPGx6Rqe
         EfxBuDKV86WDzqZcZZ/F5C18ilxTlGTRnm3r+3mEeiGWfU+82FR2zQXt5KegptLRRBMX
         /VDTWjPQbdURSMi272bYEj67Yqb835FltgV4TOCxLMfANye/bja8PrD2qBvk/xizMN1W
         Vv4G1MABzwQkaaeTAdh0MkCv6UhVcWjTM3Dnda8IW8wPT8jlOsUFkb8/ECvsPpz8EMDH
         jzCzpS58X4GKvCxolp9xuM4l8WJ8I8biNj0r8ovUhOQZBMFOihL3qqMGsrX4+HwSMmhm
         gfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787656517; x=1788261317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GKN8g4QDBFDef8bKiPT7Dvw3NomvdxmD3jUAwR8N0Mo=;
        b=I9R2uIfWvWt3xFIVHYRok8uN3460igZUp5rc3kPgqiUTrbb0DJ7CzOmdHSPBGltABX
         /rOlbg1lSPkQVec68Jo66kCe6Oth8Rg7WHNWo0Ng5Ln3Y1SDqq3Q0HVHTFIAwOpRTWrl
         siLD+1vc9eEL3clEUAfVNBkpzKZ4Xbr538ADz/jv0+CveMmM9zBy+gidAKbQjN43LauJ
         IQfjrgYSd/f3jzhUw0/aCnSAhwKIWKnatBrHIAQpqlAhfTS1Awlz0Ly8DWuWMcg9N5Co
         9lw9kwnNx+yMInWHrk/jdTc+Np2Bm53E6fQzIKT/ygEoAeh4Hw7jF4G1PDO8CHiiSBgg
         GR2A==
X-Forwarded-Encrypted: i=1; AHgh+RrjOg6Kb52NZ2/Isfx5pDUMn12LkPO36zpRvokkvrDW79Tx4loP9gXZk1bMVJFoMNn7ecBqgWc=@vger.kernel.org
X-Gm-Message-State: AFuF++lm+0oaR/hiRs+9+1v95eLmzJ0nZjbQbsNnbpPJ3gj7KKZh/ySD
	H//ycQYGMFSJvaSNJhtNjS20xS3IjZJo8rDicJEdnutc4jlvAXdY93PN
X-Gm-Gg: AR+sD12N9MWSe5nCMT3+ivhDRxO/C5S94brxb8avGgF6L9mf5c6W34pj5NrF4TpbvTg
	ddBHD89+L0PBmJanpGqX5tyT+nSXtEZr2S+kk5011JWTe+8q5DjDJFmz8cs2LilTkTuveSUtuf1
	Ci9vG7rUkKfTgG5Z4O3oBEnvgHyq57nYZPS85MA5EofeWqOP2rgZQMI/8bGI83U4bdvNrgQMouQ
	ckt8SnaqKVN7Uw+yjLzcg55WbLp2ewTDrdlkVTYsRY2JVqFua8Ve5vgfY+DGjSULytrYf6UII4u
	44XIOXVfcq3m9Fvfa0sFVO/+Prlz0XozSPav7rw06Z4CG3dhjInk9dCKTQv0nwFd0/L3OOZ0jyu
	M5ruhq7DOJmwXdjJcAKgqE0jrSctgZRf4ytuDEFeqoDuVLnP2zTt8TWOpc/d3QYMTMcFKFA+SEq
	wOGThNh2xonv0lC7o8jHsHo/ttA97GyH7gdsW72sLgTGm158OMIg7FOw/zGcfftYs5ieLSaJLh3
	cgVuk2ifQGWHQnjPgqvxzND/B5m4fLs5HUirJu5TG4=
X-Received: by 2002:a17:90b:2712:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-39645b19ef1mr8212048a91.17.1787656516295;
        Tue, 25 Aug 2026 04:15:16 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm6628824eec.30.2026.08.25.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:15:15 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: lovekeshsolanki00@gmail.com
Cc: brauner@kernel.org,
	eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	jjy600901@snu.ac.kr,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
Date: Tue, 25 Aug 2026 16:45:11 +0530
Message-ID: <20260825111511.328160-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825104601.315401-1-lovekeshsolanki00@gmail.com>
References: <20260825104601.315401-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch was intended for a different report. Please ignore it.

Sorry for the confusion.

Thanks,
Lovekesh
