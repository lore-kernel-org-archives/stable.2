Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5535B136;
	Wed, 14 Oct 2026 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941272; cv=none; b=fKYZNRhgFy4y5/8xHD55PeTs2Jwux9dwiG9RHyH90S94XUHeBeU9v1g4ra1Yx6aP6Dks9tDo8Q+Fq9zgisA0H3DOVOyT2r4wq0qTes2orHDS8VVwHUgIhB3sHotkZF2D2FtIHHR68uGvpCp0CWgpc0Asy9DKX3wQ9nNts45ydcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941272; c=relaxed/simple;
	bh=eT/FW8zoIdGOUXoHCxa/EBG2MaetA5Sh+CtQ5378w2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3NXWNHTv5QlO1AcNkkV/NfaZ35250Q1yLEY/n4GDZ2GFt4g6KC1rt1tAyyTq2mSsl0VDg8kqdnNb7HXVNgqKqE20X4lsiG7v5NrtnDRGPk4Fguy2cpub2b4ybs5hvXf210qm+jnQcsuufSFUwZaLaQpvUCEYaAgSjJfJY/VwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgS1Csnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgS1Csnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628271F000FF;
	Wed, 14 Oct 2026 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941271;
	bh=aF2lwkk7Gc2tc2b+mw7WYzN1UygFWytU7E4pDnfLBiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgS1Csnw9aWyWEkkzSijQJuUTLzuZN5+ipl+r2eA+lk1okLkGhSXQApkhfp/sA0dO
	 PoSGA4fRugzBCGZM9VMjvfkh1lA3fPBpUvHtftHtOwyZw9lXZc5ZV9MJElL/C3EDdF
	 /7qAyWb8xOc3DMjretG/ZM0qfq4+wAErgRlud1jCTZSqy5lANz5VSnVpnFFbcG9JzG
	 bgpQrIY010WSHbxagQpa/0xlHEEYDMnQuBTt2Zn9zMIzmTAd6v5h0QqvxM9/jEtsAv
	 +wzI2XnQNzGhGzZFRAadiTIRz8Xqlof2lF1dPPBdFfjJma6XB4Fe528ZU4x6zPLaTN
	 YrqQGa/860LXA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [STABLE v5.15-v5.10 1/6] HID: hid-steam: Fix cleanup in probe()
Date: Tue, 13 Oct 2026 21:27:20 -0400
Message-ID: <2026-10-13-1-daily-reply-0030-hid-steam-5-15-5-10-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091215.529531-1-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> There are a number of issues in this code.  First of all if
> steam_create_client_hid() fails then it leads to an error pointer
> dereference when we call hid_destroy_device(steam->client_hdev).

Queued the series for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
