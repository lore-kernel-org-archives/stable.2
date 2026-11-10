Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315317;
	b=COhgWQQks32GuGtg2DjL5oPjOP06jHUZMjnHnlmhBZeqwpIBpWOvcXD1eDZ6p/r5JG0A
	 eHIwL/wm6+GqSw0oNNPRJALUWq3cTGyjOLwO0Hy68xCyQyn7vye+oA/0GxSXSGCHV0UN5
	 WYJKNe7EhICOQhV1b88rG+F5Ytdenzh9Yob+Kb9zCPZ9wXD8HeBUrnWqhlCuDlgrT2/U/
	 NP3a8FjmuTe4vhPyZ1RtFcoJB0HO18He6ApuDNRJ7XfV7nMcP4G/CH3ikCmPInlIXGUe9
	 znN9k+mitAnVhC7UKhvbcpIiuOv8DI8nfYF6XyKGHzBmp5WVuqoUx08LcHmywfQQtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y9a4dXZz2Gh7g55gQ4afYnhsZlVmNBXmZzJsbUHMreY=;
	b=IgE/F75BlJFWJtfiJofOhl5rOxX6xSc+OUo87y7BXm+rkrPGnCYXlSIeRaPuvfa2ljED
	 XmbNT73ciAS5X5vyYXx+9r8xFy1vixiQH4nE36qKQug5eW1TTN1eIyz2ySaZPxnGDnXKm
	 /ErLO4PzXgyWCeBTmsX26s3wI9nBBBFed0fBJX1k9YumxnBpZs/T8zBvrQJt4bWrP9You
	 vq7/gmSNXpwHzjRwIZDLwdHKBd2UcghRNjCsXRvAebxVQKyWJARVCRqaUnr66To9SV8bo
	 TwNEYEurribWQcdXfTrjdOcvQ6+bmhGBScsW2bFL0yHcYj+NzXtPVjaFbmAGlZ8XZxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HKElo7IS;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212D60A2602
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D212D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HKElo7IS
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so908722a12.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794315316; x=1794920116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9a4dXZz2Gh7g55gQ4afYnhsZlVmNBXmZzJsbUHMreY=;
        b=HKElo7ISktPKWfb9xeQZupSjRFJ5M5d1kMcDar0ZaqBwFUrTylEq+AsYWADn5hN0fa
         gOLFwTr/tOo2+ScR5xdnmknTwTZtDLQD5eFUwJr1MR0qzll3IgBcKi5w0nIJv14MsnD8
         Fv+Z4RbppADwrGnnEvgeqNWjZ5jv1icT5/6KUJ/pzrC1bjBgHDxiqg9zKw5gGSkUoHF0
         wkiqPMXNs+41ltOOhSAySjGbzyjUuhdC6JWHM5/hnUUAopO12WmPr4GtgFKj7j8lhtMj
         AL7OgMejVq94e8pXnA1vkau7qQnT1SBA0a9ksb8bP20jPQiXc5y+oqi1SgZq4T+/ODar
         j7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315316; x=1794920116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9a4dXZz2Gh7g55gQ4afYnhsZlVmNBXmZzJsbUHMreY=;
        b=HWYTiZiYPpDWhs87Q0B7yUHiRXZ8+5SzIn0udMlcClnN2uhrRRcV6yTy6peXEnj3Xu
         O/HJ6/4qXDO7KY+6eSpBEJNxBxg4xHZzUa7/VAgb+AAFVnDeIDJ4OZEF2MvE7cI3QYkg
         P+f8eywK5wG/CjedvgZl0yB6rIYHH4G4TMaa3rHhgrNirFOPr5FfLDrvXGo8DlBmbAH+
         aT3ftj+DVrJa1OeO2yBgEqxSevw6OjV7PX6b3iS0PISMUB7xQ04/KyvG/uUnGR74pxZe
         Tktc0NOgT5fADddHULikOkmE1aY7gZOYoFBRh3Gq3roSi0AG4A1T07YNbuGq8LsNLTa9
         l8sw==
X-Forwarded-Encrypted: i=1; AL+hErHviSdSZmAZ7QpZ9lTDt6pxMzoJFfxJqtbsaaaDSKJ56LDf+xacAomOgWXxZ+I7tgLKTzcVn34=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t2wpWUl5NOLoyJRbQXo1zQ4iz/9J6UhY+qQsEH3bYdK+nVcpd
	lfOfiuG3+Iyy43V9Ha4r4VpPRIZLs7FyLCy9rBKyBlkBT4M78bnms54+SWZLzH/eE3Q=
X-Gm-Gg: AYBFou37XgpLHZpPSj/b0Vc+ZANvQ7tov1mC+nC6glQcu7BCbVDjBgMmb7/K9/IfAi4
	t3zCJJFK5skhKzDF5boXKxLl+Bp48Yyps1Y+ul6nvmjKEUQHaptxZcnp0WBbxaXsBSzIP/OkMsm
	tyzxd+Y7T7h3iNhIumyE5sZxPF4vAC2m+FAirqMv03dHPfn9BJ/0ya2l6pAUib+GBFWsY1TjPEZ
	4IU5cnFdBSHFSkLOvTXxJ4Q1375ZSI6MwNBBRsOp1rsLAGFmOG3/lT9Pymt9vMsA35J76sjH6sA
	UjIyprVEGq5tGF2I6DaHwHDW/qkC61kNqlPj0Af20SvJrQX5ji9txKZ+zXryTUR800draIdU+pg
	zNvbOKZLpzbh48K5mBss1/D7kktIsGrogosh1QejDKwlJVfCe+5478uI7MzvcSK0wVX+wZ4aufK
	dtUv+2lSoF6Q9RBYcd7kPiW4lUPwP/JEqMmfbDd3mSA9cFyj5zOYW3pgwnClWmRPDkyXWfOEe3s
	rdpa2W7cuZ5yVpQUFjdE6/GpSTUCT/xsY6Y9FWJzjia7un211gFOmwA+J4+6PljBwEpnc0J65fk
	cJphpl5H8dIEhm7hwLt/HhBHmJVm+Z5AE9He5QwLckQ6C0YU/H2nF52aFaQcUDi2h/fTV9sVesB
	iecaSmb8uyIht5v1pjlobOrtCgLJkW9XCgnDoJA==
X-Received: by 2002:a17:90b:1dcd:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b166d31305mr2579742a91.54.1794315316112;
        Tue, 10 Nov 2026 04:55:16 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:88e2:4271:a9b8:cc50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1690eb517sm1631666a91.4.2026.11.10.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:55:15 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sstabellini@kernel.org
Cc: jgross@suse.com,
	oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] xen/pvcalls: destroy the per-socket workqueue on release
Date: Tue, 10 Nov 2026 21:55:08 +0900
Message-ID: <20261110125508.47483-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <604a9832-80ac-107c-b36f-4bb338519cbc@kernel.org>
References: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr> <20261109122324.30134-3-yhlee@isslab.korea.ac.kr> <604a9832-80ac-107c-b36f-4bb338519cbc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 9 Nov 2026, Stefano Stabellini wrote:
> Please move the call to destroy_workqueue() just after flush_work().

Done in v2:
https://lore.kernel.org/all/20261110125002.46683-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
