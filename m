Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FEF38E8B7;
	Wed,  1 Jul 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933136; cv=none; b=QEmQuVV8BTtcQksgtehhelmmIFvzfzIymThvMMQ8wmyYd/gOMNM58soKg1TIYUkSz9krTw0O0VJxWARHrDv7vvtpz6Fys5ozCIgdZGlLNNT9EFGMkcCZo0nxZbxSq1SpgTJrP1+oSjXkL8Y3/OFncKMEZBm840jjhj2qKNcT/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933136; c=relaxed/simple;
	bh=OH5EEkppZ9NjgziN3FSpK79YkP3ZYDPu14TAWEBCnlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYFLrTpBIwSin6v1PxVcVS0Ktuso2dJWHhQ7ME9GCD6gKY2I/hCxZy7AFwqgarFNy5xF26LPcVzLPxZE5zqmAM8lkJ62REaaEAOHwtr8h1D13UpGN2DJQgVNPcdDfMgrPfewovI+FBMHnudcfLuRSPlP3y8s7VnSQjB1T6VqnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6tXH1a4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6tXH1a4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880FB1F000E9;
	Wed,  1 Jul 2026 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933135;
	bh=FAVN0K3aWofL7Gfpend30Bgse66P/dAvdfdDljeXASA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n6tXH1a4qFiXvds8LEgTYerkotQrPIZXgdSdGVfflQ+mVXeO4f6SJpvqy5uX+oIjY
	 bFSO1cO4J3u2MhrWnTLEBPMUF5O1Gvv4FyaWP0vbo5k7ssgX1Jb4v9sx2ew8QeKNuZ
	 4YIAaILSRWwXfl/oUebcbCvf5KQ2ScC2pcgNFYIGPQMPSOV94iK8Pei0TbnqtdtrwD
	 iJLEGLH/JZ1Jfl8djXlrN8vgDzUJeyXw2DAf/YarEJ6JXN/R79T3Iov4HiydDTgk6i
	 l8ThFhckGncW1As/ADf1EV4a3WUcskCKOOp94dhorRyb+OekRuHy1EHBzJnxS+UGjg
	 D3iO7z/m0UBfw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: jikos@kernel.org, Trung Nguyen <trungnh@cystack.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260701171320.16367-1-trungnh@cystack.net>
References: <20260701171320.16367-1-trungnh@cystack.net>
Subject: Re: [PATCH 1/2] HID: multitouch: fix out-of-bounds bit access on
 mt_io_flags
Message-Id: <178293313430.4023988.4170644137345282702.b4-ty@b4>
Date: Wed, 01 Jul 2026 21:12:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 02 Jul 2026 00:13:19 +0700, Trung Nguyen wrote:
> mt_io_flags is a single unsigned long, but mt_process_slot(),
> mt_release_pending_palms() and mt_release_contacts() use it as a
> per-slot bitmap indexed by the slot number. That slot number is only
> bounded by td->maxcontacts, which is taken from the device's
> ContactCountMaximum feature report and can be up to 255, not by
> BITS_PER_LONG.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/upstream-fixes), thanks!

[1/2] HID: multitouch: fix out-of-bounds bit access on mt_io_flags
      https://git.kernel.org/hid/hid/c/8813b0612275
[2/2] selftests/hid: multitouch: test a large ContactCountMaximum
      https://git.kernel.org/hid/hid/c/b6eb022890c7

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

