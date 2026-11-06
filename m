Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.157.154.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930055;
	b=WM8+/fR7rx4/dU2q5mqN5WoJ8UOP+BdwE+xoeAPtdWGLR27/KzB9iD8j0X0AiFka1nu9
	 y6hmYoWDF+lWsqUD7g66oPYoXyrBkwoMOqxPqCDlyNIbirNxh5X1c+PAtC9KfAY1zYbDy
	 r63s0njAaIA1DDjrcmsQtr1YLAcEyUzf3G43BkSEUq+b0OZlvGzub0YB9G7QgV7NOQ6HL
	 3K5c9BCjr93VnxvFZTJJF38phuDBE3WPPZb69nOtjJknR2YUN+mqNzX6sZnGPyCAVqQWT
	 D7QiuUxNaq6NeH78N2j6pKVnbA7QnYmhC2LXSBXBSb+JzZgN1+BdGws8ersTejNUMAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930055;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=GNXxh8Lf83NrQqN+daH2uR5w2/gfQKxV5ZK7nR4UdCc=;
	b=vWUy7AIEc+CV9ZMB0EfCv6VZPCdfWuR7Cxg6tPMN3ssPA+yCtgEoPMt+UAoWF1wzTrEn
	 zwWZ18/Jdtr2JiU45lHwQkECxsOfGNl4dOy6N71NVT/84YWNYGqHCN54qDEfi8ASoZBZY
	 nx1NX3ZgHkylFS3wBOXMNLa5AFJQ+5IUbsNPwvkYVnSqMb1TgJ1KNvlocJiA8Sm6JIAcx
	 NCOdWP/zDIM9L91tNY+esqORr3lqDiAAL8lWCVVn9wQHJs9cU4cBClkYAVUBXQiM7XGlx
	 ioNULRQzDdcSBIGdAVhBwtNSY4osJI5xtX+1cbRWs4wBEVDouqv2Pt92Ytolzqp7w0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cdrolet.dev;
	spf=pass smtp.mailfrom=cdrolet.dev;
	dkim=pass header.d=cdrolet.dev header.i=@cdrolet.dev header.a=rsa-sha256 header.s=default header.b=YVe7uPzn;
	arc=none smtp.remote-ip=216.157.154.162
Received: from opentek02.opentek.ca (opentek02.opentek.ca [216.157.154.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AB606A31B;
	Fri,  6 Nov 2026 01:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F29AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdrolet.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdrolet.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cdrolet.dev header.i=@cdrolet.dev header.a=rsa-sha256 header.s=default header.b=YVe7uPzn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdrolet.dev;
	s=default; t=1793930047;
	bh=GNXxh8Lf83NrQqN+daH2uR5w2/gfQKxV5ZK7nR4UdCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVe7uPznLyweeYl5ngydOtveu85VAgvyiUzLyH/+m2CDMufteT8IlefeoAjDnrXKE
	 HF0UuYNnzmEemElKxOv81NRcto2bO/aIyi5FX/1CL9CbSXhFm5AxPbpT32pCUhMVVr
	 kEhYcuYxn3bT+WohP5aHExraiTM501Ybgz8Tmb1WFyN8Qyn/fKixpMI8/It27ruHvO
	 cZuJZGQccJrQO0z0KKYF5fg9KYYkrm8WSZqT+LG2yTmmy6/5H6PG2KBbjM/HE9ph0y
	 n6CxVvqcplbgWy779lBdBCKkDRIQTVw/JdC4In3SBcAYhnEJPEEf+qFwsMdbPuxfEc
	 xwWeem3cuo1oQ==
Received: from localhost (bras-base-drumpq7715w-grc-39-174-89-1-234.dsl.bell.ca [174.89.1.234])
	by opentek02.opentek.ca (Typewire) with ESMTPSA id 00FB81260B1F;
	Fri,  6 Nov 2026 01:54:05 +0000 (UTC)
From: Charles Drolet <linux@cdrolet.dev>
To: devnull+b.danias.tutamail.com@kernel.org
Cc: b.danias@tutamail.com,
	bod@kernel.org,
	hansg@kernel.org,
	kieran.bingham@ideasonboard.com,
	laurent.pinchart@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	rfoss@kernel.org,
	sakari.ailus@linux.intel.com,
	serin.yeh@intel.com,
	stable@vger.kernel.org,
	Charles Drolet <linux@cdrolet.dev>
Subject: Re: [PATCH 3/3] media: i2c: ov8856: Power off the sensor during system suspend
Date: Thu,  5 Nov 2026 20:53:28 -0500
Message-ID: <20261106015328.11301-1-linux@cdrolet.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104-ov8856-pm-fixes-v1-3-1958b730ce66@tutamail.com>
References: <20261104-ov8856-pm-fixes-v1-3-1958b730ce66@tutamail.com>
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
X-Scanned-By: Typewire on 127.0.1.1

Hi,

I have tested this patch on a Dell Latitude 7320 Detachable with BIOS 1.48
on Ubuntu 26.04.1 with Linux 7.4-rc1 + patches for TPS68470 board-data and
TPS68470 privacy led (tied to VSIO).

Without this patch, the privacy led turns on when entering s2idle and turns
off on resume.

With this patch, the privacy led flashes once when entering s2idle and
stays off. It stays off on resume.

Tested-by: Charles Drolet <linux@cdrolet.dev>
