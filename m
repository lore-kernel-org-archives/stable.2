Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CB3B42FB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052369; cv=none; b=chqbjeE+EMKsij95X04reA/WrmyqjfWCIs1tNQBwJ1MWvR4Khn/OeCBhiEwFLywpwt4XmUyJetX7rIiibVtO4XQgFoFydEenurF7L5zb8+pCG6NbbSKMf7rWDhdI5OXQjy8lbC20xmw7X6syaoyc+EMj9je4uC+O6v1ngiJM8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052369; c=relaxed/simple;
	bh=4oGFoAucb3tbHa8WwuUU9mOHcdoEIPXf4i9GftWnm6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJuEka82VQZD7r2HjzJt7xEMwnH88pLtp+qQb3++TNHkAZOYQvZF50LaaZUs/fGCtlre5jgq0g6/6kkI9SwFNrZEiecSS14ToJ956tBznsyNJkwpyZRdgppRvYcR7KM5OkYSeQCLaOwaFyrQiYFLuV3F+jW8T5CwOvmC96WsPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHzVPJKW; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHzVPJKW"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso4330930a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790052366; x=1790657166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yu4lnjkEeLhSQSw/zgoMmATHDwmlodTsiLJw7uhCZBw=;
        b=SHzVPJKWqjwc0jLYJ18n5wY9h512UWGP+cdiFuI/SLohhsFQXeucSGra8pSmfXZ1Rg
         FiJgC/Mlf2fMkuMRvNrW6/wSr0LI1Unzr9r34f8fU2TbneKJSLRm3Kc4QPcn3ErOAE9d
         951+z2ZP1fpYJoiEHyepmM7FyUsderF4hUWASi/ib35+mStKX6UOMgLEzHU29gpvWV94
         LrPqiUh8CtxjB08EUA5rXERQt59rO2ilcQQGDXQmo6HpLXRG+uV/w4jXKhljheM4JN5S
         r42jd3MpE0zxW9L8nAtKARI4BX0zifC/x6hfts1XCET424rYNPbDf5LK4Ciqa3ZUBbfh
         i74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790052366; x=1790657166;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yu4lnjkEeLhSQSw/zgoMmATHDwmlodTsiLJw7uhCZBw=;
        b=nI88t4azrbQuv96l5gV4bxOfiSG0OK8zIkxg9bv8xaCHTrtNherSCSvlNNBBiZrrcg
         kSfirvRZ5N6j3n/A1l/qrEL5QUdzWQyf5z7EE2NubPF3TGLiWIBbsUYAZ7aZDx4F//Yt
         7te3JyqOY3Hub25+ibvbkjk6SPvxcEe2+hXEEE/P/x+TfOIQ6WrD7vHB523fg1yrWJX7
         R3zeTT1PGzpQovlrxe+DR4KZ70eL3MejG7Cy0lgv986/0NZ1KlwRp5hSZjxwfQv0Ekmz
         J+snjN6LwKbribnm4PASaOXzHCpfzS50kVE7glYX1nmYAlkGR6loj9lEh8m/CcZYc0Tl
         ONzw==
X-Forwarded-Encrypted: i=1; AKwUvBxov6eASNyhOsi4riozDFnuN7SfP3hRj8/5p4VNSzU1Vo+RJ7zEH+ViFVfcNBmUPXDkUNACAA4=@vger.kernel.org
X-Gm-Message-State: AFuF++kM4mn2AksIVXXx3WvmpKZxxuu/RQRL62B8W1VCFKPiuSiSiXgC
	K9RZsmHhWr00UhcFSIS6gRIAGBT8d2UmOgUlrPU06wV2UGcxrZ0knEiZ
X-Gm-Gg: AYBFou1gYHhZbqKD1c2cAKuu1Ngkg7LOhjs2OOcgrMe2iAM3jw/YUIkNlyiPWq3juSb
	GW5Y1h5pTeATPRNMQamVwQhR8DebSm8FS0DPJWCTzOEidt2WQXDqTLzWVXL4nzYToUX54M8qZiI
	2Lmoz84ErrDMQ15OVcIwteFTjQtU/iLYJDSFICwfc9WJzTwDZjq9fgkoVsAD7Ze6M4reggeUwCw
	ZGVA0aNbQJimS/EkP5rMQB6+MpYfZlNr9xe/SDjQ/NcZ3fq4CTYWizlHkrRdDpYLzgks8DJariQ
	safXrFSbnD8Cc/1OaKZfQD0dQA9vssat9scGjcRSaO8vGebbBLV8L01crUCJBKwx8STMlAjZL95
	K5vzgI+LbHnXR1kjctED0utFjlwISPP3ZKWu7p/dLz/ihiH+pm6e6LJRQ/Svh4sXOqYmJEPqAE7
	PRkdwoVz+tN+mSajLFX4/2e+EGOzT0kjh7zbeERdN8QUJpKzOy0lX05B3Hl/5a+7w2JQZEP26OU
	MjadSR8/r9nmLaeg12sdnRhVPllvqRD4AYT7zI=
X-Received: by 2002:a17:90b:2f47:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-39e54cc6240mr18299564a91.3.1790052366112;
        Mon, 21 Sep 2026 21:46:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:3443:b4ea:307f:cc4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e26e70asm1152325a91.1.2026.09.21.21.46.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 21:46:04 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Yu Kuai <yukuai@fygo.io>,
	Song Liu <song@kernel.org>
Cc: Xiao Ni <xni@redhat.com>,
	NeilBrown <neilb@suse.de>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH 1/2] md: fix bblog_size-driven OOB read in super_1_load() and super_1_sync()
Date: Tue, 22 Sep 2026 12:45:56 +0800
Message-ID: <20260922044556.30746-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io>
References: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kuai,

Thanks for the review.

The 'else if (sb->bblog_offset != 0)' branch handles the valid on-disk
state where bblog space was reserved at array creation but no bad blocks
have been recorded yet (MD_FEATURE_BAD_BLOCKS clear).  A corrupted or
forged superblock - hardware fault, fuzzing, or a malicious shared disk -
can carry an oversized bblog_size (e.g. 0xFFFF) in that state, bypassing
the existing validation in the MD_FEATURE_BAD_BLOCKS branch.

When the first bad block is later recorded, super_1_sync() copies
sb->bblog_size into bb->size, and md_write_metadata() then builds a bio
larger than the backing rdev->bb_page, reading past it and leaking kernel
memory contents to disk.

You are right that fixing super_1_load() alone is sufficient: the kernel
never modifies sb->bblog_size between load and sync, and with the -EINVAL
check the device never enters the array, so super_1_sync() is never
reached with an oversized value.  v2 keeps only the super_1_load()
validation.

Thanks,
Yuchao
