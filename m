Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBF51812A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682445; cv=none; b=OxUIzlzndHGwQHz231YDeWpYGLQAeK0/CLwnjVpwItJc0kkkBcadp63xVMhm0Qbbyc3BBcMpSdxFelfjzJ76eO/AUbuR8W40VlW/z4RHQzuSI4JBwCVRzz4WxocGJn6G9iu85H/4ulsZZWkv68xRltW5vEbEllZ5BoPi8/uScCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682445; c=relaxed/simple;
	bh=auO8vx1zCEc/BT+Se+M9GZe6jZ7lQ4XST00kVv5lCUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rRi2qU27cU76RlxKhhcRMCGwhhS5C7A6niGO295pet51yMbeZ74mp/A2ukOsltsJbFr7Y5fgRbiKA32qvezH+5eocTke9SmLH+sN/Im88CssaN1XQClsHozswRSZykX+g0pvhPQqgfmQAShwrd8LLbm9q3DPthOCXds62y1tjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LX8rgYEu; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LX8rgYEu"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b6f8b8113so169322eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790682443; x=1791287243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrtlH6fh0bdY8+LsO+q/VzuQ9gl6JHaXCyoZ57Q1phQ=;
        b=LX8rgYEuCs6CKNOQmX7Fm2p0fRH+V29wUua+DOblZ9yHWkX5Sbvw3ocBaxchS6/Ff+
         okUxaJPqwoRuc1t1Bgw0fVCTEzrZYr99UkOtQI+TbARp921GswuBRsm4vHaTJn36L7Wy
         zO/lbrSBF1rQZGVc8k8Zh5mK3hc9CX8iQORchmBfwtMhPBnCzhHr3NJ94HRC3rvO4en7
         1OraFasrLY3oRHl9jo7fUSDwJSXc0ViLxf0h3dG5AOe/jHf+RRdGaOadyOeuVXpuTFfj
         SuaY/dRxdFPjTYG5eBsE5NnDc4z/w+7QO1ZB4LqHmKOZVijdohJOWsmBrYdAgB/WsrwB
         QkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682443; x=1791287243;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrtlH6fh0bdY8+LsO+q/VzuQ9gl6JHaXCyoZ57Q1phQ=;
        b=E1snkYUocmULROMedQaQs0Pougv5CvnZBlO1T+zC5Vpi+lljeTeni+vQaBjKr9dY4H
         x8zPNckMa0OEov5zDVfE2S4Vvcdevc1mwozXp06ce2BOsRXhsElp7ZifUxzb6B4rjWfQ
         j/x/7FqHrufm5MR6L4T/vhe7E1Ici9DdnmCJnJEbWpnYbGTp/Wk+Prlh1dmm+3+4nD4M
         kkBLE0iPzyFLbThe+bwwgyRgdroYwna+ngNiRWavVEQZDUy/kCJlVQtNj0swXws/80PP
         skNU1882yrMfZ/ahTH7j/TRfrZcJKEPhR3WaGUAxOsBxdmD0QJ9S4WZMoizcLFxDOwP9
         7VDA==
X-Forwarded-Encrypted: i=1; AKwUvBxy6mp5YsgDb4/Kn805lt4HfxE34Xg5q0NfbkZvNHlKD3Bf7y7sd2cK3xu/PtakdVHgzSgHTDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhYjTrQO4pG9w/V1GIfOSa9GHvEQYp/WXd4jDEJn1p7AMzTp67
	ptTy6Q6r+QyBaF5wZdsrreMPkIhknNLpmQHUjlYopqOkiK3P1sL6eMrtvDIZWiSY1h0=
X-Gm-Gg: AYBFou180A2B7iRym0xSwCEW0MlKGlZMheF7sfD254ANgeXkCEJSPAlyyPNJNwB65Rk
	5E/nzYzrF5PF8EqO7enXAYDEN9nE5MMN38lkEGZy3+HVrnQVrJbYvrEAmAa7FCXf2Fjos+k6mZO
	SyBvrPqv+/DBM8/rY6XPx5FyAhjL5Rh1t9VnaWpG7C77KGO4evYPJJQi4B923OzabvJMe/X4XIv
	+w0SfgM5qRUxFi+9U3AZ9MR9qeP1LikLP732F1gsyHbdXMV4HGtt7IhyM7wwXQwHQ1eYiOsTXPt
	B8Ym0aslqTm3F9SiOZQNCPqqRJgCa/n1mNEFGaQks46KzotDKw4wHnDlqtwG5qj5Yhm8ddORytN
	Ytlidt1VRWmWSKUvMegS7eqjW69izkRg81JoPiSD8en3hWv9eWmCXgCrIo7xZHVXfcEqtY8Wfym
	vzPG7aR6yNd5PWsmMqS2G3teECXn7c2i8TaXiR/Y1AovUfPbcTl0TVY92wAToqTXiGO6Uh1gzK8
	7BXE5JT9Y55JD0wfkAdQgLAWzxU1EOo0BZ4awoUWq5gv0TZV490kwD0fdhqnVTecHty
X-Received: by 2002:a05:7301:1a03:b0:33e:643c:91fb with SMTP id 5a478bee46e88-34af50f9957mr2407486eec.5.1790682442660;
        Tue, 29 Sep 2026 04:47:22 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341451457d0sm39636842eec.21.2026.09.29.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:47:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>, 
 stable@vger.kernel.org, 
 "Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan" <ytan089@ucr.edu>, 
 Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu <qingxiao@tamu.edu>, 
 Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
Message-Id: <179068244058.1205226.1765319338142659278.b4-ty@b4>
Date: Tue, 29 Sep 2026 05:47:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 29 Sep 2026 11:33:58 +0200, Andreas Hindborg wrote:
> I have a number of Rust block layer patches I would ask you to pick for
> v7.4. I have collected them into a patch series as well as a pull request
> so you can use whatever is easier.
> 
> The changes cover
> 
>  - Style and formatting changes.
>  - Documentation fixes.
>  - Fixes for missing trait bounds that can cause API unsoundness.
>  - A change to set the owner of the file operations vtable in `GenDisk`.
>  - Two bug fixes for the rnull driver.
> 
> [...]

Applied, thanks!

[1/9] rust: block: mq: use vertical import style
      commit: 020185c5f4a5590267b825dffda05eb5d45dfa5f
[2/9] rust: block: mq: remove redundant imports and format
      commit: 06e75dbe894f260651627c35e0f36536c4894536
[3/9] rust: block: rnull: use vertical import style
      commit: a463f71c492336f9650bae7d7166b66ee87461e9
[4/9] rust: block: fix `Send` bound for `GenDisk`
      commit: e502b667ee70a7fa2a578e7722672ecd4fe0eb81
[5/9] rust: block: gen_disk: set fops.owner from driver module pointer
      commit: 67a11f2e076016f054dc4a4a637d9b37530b7908
[6/9] rust: block: Fix GenDiskBuilder block size documentation
      commit: c595572d0e49c79fcefe8db8e3e4f4e6e1fab734
[7/9] rnull: fix geometry store check-then-act across lock scopes
      commit: 7ac697d4a08f01e7aefdeb1f3e1d6f71b2cdac0d
[8/9] rnull: configfs: add power to configfs features
      commit: 0cd698e89375d0dfc257f9ae978420aa7fe5359d
[9/9] rust: block: require `Sync` for `Operations::QueueData`
      commit: 67b7a2728e4873e64405c5564fe50f7123012b71

Best regards,
-- 
Jens Axboe



