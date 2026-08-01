Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C63A1D02
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548418; cv=none; b=NNb5UrTSSAyB6pgm5Oql6RULS76UAfeFksuEuUuLES8DPySj74bBBsa5025UuGHtRPd6kpcfZctwpImaNC1thFDVY0qGGWK1ek0YD3oG83ZY0qIWhIcRV81tqQk2dZBqQbjSXK7dC4xajZt2qlGBCASDfFb2O0MEPahX9KqW1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548418; c=relaxed/simple;
	bh=wepyDFHgMcrMO+MHXqpUbAyg/SST7XweOVCsQ7CS45k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdJkiG1fHHvSALXLA4ZrIJpIGBWOD4FV+1P+QUw47bQggHIwSn16X8Tp9YrHLbjaQPBFDLUpgtdSuuTbr7GVUG4zVOAqmsouaBOLPgKNXAKLZJLXg9WMt53gsvn+YjH2ZX/i3k4W4tKg7CfiKZk5BGKlqkUkroTKF468sm2qZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpcACG/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpcACG/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9A31F00ADB;
	Sat,  1 Aug 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548416;
	bh=4HqAaO47ipHkFHFEFbVRSVgJS/pPUmGb9M3GJcUhEG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZpcACG/uMrkNV/snqgahEgkM3LTcW8Ltzr4YOn1gwC1anby2v3+WC/YqV0gQXF/wq
	 66iznhLE3m3uFLEuYKas2c+GCwJgaDrQiABAeWUb3u5X5wGYIt7Z0wW2flS8HmPsnh
	 2Ta7TczX7FFko6TNmDjkIcDFpNlgyuJUYFTHB1DelJ83ndGXawRLs5g19cLXEBIYPY
	 zCzB/I4ppygFKYt76Pur+XfCENKOsu2EjERbuOsEqFDG1ytUQvyoGmXzreJngW3o18
	 AE2HedDivclESLRqGUUivKbsFUTYBJGqy+EOS0uhXS0poAaYDrMIciksJD2NimL3CI
	 BFcVq5ltendvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 21:40:06 -0400
Message-ID: <20260731211004.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731105223.732829-1-ribalda@chromium.org>
References: <2026072041-maverick-blooper-4a13@gregkh> <20260731105223.732829-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 10:52:22AM +0000, Ricardo Ribalda wrote:
> [Added JPEG_MARKER_SOI definition, jpeg header does not exist yet]

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
