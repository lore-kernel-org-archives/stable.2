Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59901DF73C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499700; cv=none; b=uQybYC9fH/9O8phM7IDMzmpuazu+I8CcI9kbX1XHH2FdpGO/d1c6ksKkYENcwazeKFChvzb8LNugjqg97j5jZXIOXxipoX5iwkHDJxtyFeaO7adMhHy8vEdAapn8RAl6Wk13l9oSr3rgYlCsbKD9UN1BkYilI0BJ5jrwOVd9YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499700; c=relaxed/simple;
	bh=QEQ/eFpLtEeoPG9YgBSolMRkT7cve05AjpsZBSBbgQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaoCTQMZa7TGmqlkD5K38aPXequsS9vIf+grI3V3WmWMmHtsMjkPX6OGuxXhLqgThVDupQsdFu9FIM2QVc0qSyNOq/MR7en3KH4O2MUIxKYvu3IIC83GXFflgiWF33U4FKHxm4RPT7yS3MzpH66//GEzpAIaxoFmTpadDk8Mr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cazp2wIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cazp2wIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E15C1F00898;
	Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499699;
	bh=mjokqiqOfjTzeJNyyYGkPmrt5y+rsu6XbvIMEA1xrhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cazp2wIr/SG5Wk4lLdLKms9Zf8l9+l3KGeCd/PZjghwHWmbplz48uW0Ww2R7lo8Cx
	 ICfHezDE5YwAWw3R5YqvJ31lJpnsGJa1O/AjdALT9lHoDSIoMTg3I7kOfZ13j/UmV+
	 zkQe0/9jVeeHEZmXWh/ypt9vvr/8Z6czn+vKbgAiG7Nw57A3E3sZGxHY595BpJSfUk
	 4YVw8uENzyeyHqParfuycu9zDdpbEGeo+hc6pbcAsay2TFRruGaAQLE6J1hQrs55RR
	 fihXC2CQBOwuCqtQL5ESNss1vrxIImx55cl1CACY6djT1lKBcP6ydtAONL8n3lf/G9
	 Z1jbhhb/Jdvgg==
From: Sasha Levin <sashal@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Wed,  3 Jun 2026 11:14:25 -0400
Message-ID: <20260603151458.2404783-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601083642.908433-1-lee@kernel.org>
References: <20260601083642.908433-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.12.y, thanks.

-- 
Thanks,
Sasha
