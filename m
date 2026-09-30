Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E5484220;
	Wed, 30 Sep 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764447; cv=none; b=MXH3BcugJ/FVBQc4Hs2x589LznRspr+KIf4ORvGGC9ki+kpVyKMkiHKg7k1fmT8FcW/suek701D3Iqbt58ikxEWqR9BV9I3OsR9O/h41m2O9fEl+R3YXiszPc2m/nEMX9X4gxMksncETCd+FQPyAGVXSOudrQ5iIH4ju++mpt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764447; c=relaxed/simple;
	bh=fX/eL4egHxQsD3dNWhWGGQJnd3WSpOLEOwP2vncbe6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg8Xe7faT+PkWPr4RVTrXZkP2uTZltT6rsEVz5QC1wThu4oYV9I6bXZ6CVjhkg2u8ks4cD4N1YwpWgj6m38LneEZNn+kPaAvlAl4LQf8tr8SWiOqybQRMxYx6KGUp/dtRmLx6fv42pC/vhL+JR3GL5+3sC7hhLVnwWsonauZWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=dAvfIGpG; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="dAvfIGpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1790764434; x=1791023634;
	bh=fX/eL4egHxQsD3dNWhWGGQJnd3WSpOLEOwP2vncbe6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dAvfIGpGag5mjP6H0MGU+KpbWgn0Nya5SCpZ7VVwkqgSM2qzO4AS32bhro2Jdo+l1
	 /Ja80QCkF/kFoCGvpsv5dhqYiLe3N1U21I0f56w+eMFZizjvdmmNuOtqH2dLctat34
	 ze1JPFQTYywALMxrwkIpqr7UhZ6OwWVucgBDZCDffQVf7mCLShH+IkRYciIkshyAc+
	 c1k1bMKc4f5/XybhqKQtGkDY9LfUV+ou+xfXyxGXpAIJQNKXXMqql9jSNJVwGX8eDZ
	 vMR8l00XjLq45dZ0SyZENhRSh9vynlFbgRQ17m3rrVf26QbVXot0BdePotikt4K4l1
	 tVQN5GG09L7Vw==
X-Pm-Submission-Id: 4hvrxV2KMjz2ScDC
From: Natasha Klaus <natalie.klaus@runtimeverification.com>
To: laurent.pinchart@ideasonboard.com
Cc: david.laight.linux@gmail.com,
	hansg@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	natalie.klaus@runtimeverification.com,
	noambs2999@gmail.com,
	ribalda@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Let uvc_parse_frame() report a skipped frame
Date: Wed, 30 Sep 2026 13:33:41 +0300
Message-Id: <20260930103341.256220-1-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928205037.GL4406@killaraus.ideasonboard.com>
References: <20260928205037.GL4406@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026, Laurent Pinchart wrote:
> On what device have you seen this occurring ? How did you test this
> patch ?

On no device. Noam found the overflow by reading the code. The zero
size case came from my review of his patch, done with an LLM tool
(see my reply on 2/3). There is no user report behind either.

1/3 is the refactor Ricardo suggested on the list, so that 2/3 and
3/3 can drop one bad frame instead of the whole streaming interface.
Apart from the truncated descriptor message moving to dev_warn(), it
changes no behaviour on its own.

Testing: Noam ran the series on a UVC gadget over dummy_hcd. One
format had an over-U32_MAX frame, a zero-size frame and a valid
frame. Both bad frames were skipped and the valid one was exposed.
I built it on x86_64.

Not tested: any physical camera, the -ENODATA truncated descriptor
path, 32-bit builds.

Natasha
