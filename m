Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194703;
	b=mnnAu6adDF5l09D3zJZfDVZBRlnuXg+b5fBQpSURAFwEkKIlHiklU4/NGjk+/GDz7Iqn
	 zx3N047EW3MMF1W2XPryjjIzFcATpfbC6tPEwSLiJzMLDaO8V+9C2LvALFulmOSwWY4Nl
	 Hh6nhdZRQ61ltPwSKMHr4tOOVGR2sFs2cJbeucvZBxwOPCk+tYEqt0eIgMK+JhD4bOdqy
	 6qNTKhvkb7z0C67m+mhyqN3vKxpddAnt+pFhtqk2CrgJEh9kkJ7emNcvL6uVzmOPpMJPu
	 PqOgu/9mZ1du5QO2DGbYtZehBrNZ5tBEFcIZ24bUknwpcfiuykZ7RSKwSu5TuTvywnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194703;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SGrVzFmrUDlZQoUFKvoreZt6u8C6Px7i+65Aaq0Snyg=;
	b=Q5iUDnyJKocsdOBgH/TjzGu+FPs7qxBPvfTAtXFL8XcYcan3ybJcf+4ImUNqGLxyZn7Z
	 pV9pOXr5C3qJrkpPMzPvlETWNBv5E0VaDf8TuWWwHX/Egm2c6A58oDDW07RZSPdT8cCSB
	 f6yPC9fTfHiyKBBxcPHXVnMwIb49BYLQQsRZn15bbq5R8UOiRwYgxT40g13TZeDu1qyFS
	 pDfFz1/M+8BJD5cOT19L4Tgb/vB3qNy8eMBwJ1Yh4kFlGftTJ3PrSTT4l6Ts9+gboCTAO
	 JS29pSlK+o9csx7UtjvqAJ4qMlUFx+O4Ymst++RoBY3qPUR9J8AiUAo3YwGPD6IY1vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRSXvQlk;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C66606A32C;
	Wed, 28 Oct 2026 13:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C66606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iRSXvQlk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793194701; x=1824730701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGrVzFmrUDlZQoUFKvoreZt6u8C6Px7i+65Aaq0Snyg=;
  b=iRSXvQlkiUrmMGXQ84XqkBpyjd4brbKF7dsorRB4z8XEZGjSZtd+nqmM
   +7aUf8lmjvgbcNbHe7ZLDVozmrX7RHWLxqcPDAw/431EKWcaaglg+yCtH
   L5CQEtme8YNPm1thQlSVoaaCnx6XMjzK8e4k4mado9pzaagyQd/tV6Bom
   iUq/oqB7csvjLAciekv15IrPFHcEBzSqeVmY7MYsjQ++4z5eN4w65Qsd0
   UKa1wFqPQaakX3b6njVW/mCRxg9rOd0VRo/WUPMqQ8se+pFDubz7a09j+
   uL+v9q3TXGxiBSvoIdwiBySMUt3iKDEb4GjITbEWnR3691tNcd/IIXZaE
   Q==;
X-CSE-ConnectionGUID: FgK1zlarQeewGkdaVDV1lg==
X-CSE-MsgGUID: TqrdNkQXRqqFNusDKI7QbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1927166"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1927166"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:38:20 -0700
X-CSE-ConnectionGUID: xYX52GK9TZiU7Ag8Xwncbw==
X-CSE-MsgGUID: j/z6PvjDRbC8p2rj8nw3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4976735"
Received: from jf5300-15a101203tc.jf.intel.com (HELO meta-crater2c.jf.intel.com) ([10.54.113.49])
  by fmviesa005.fm.intel.com with ESMTP; 28 Oct 2026 06:38:20 -0700
From: Daniel Byrne <daniel1.byrne@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Daniel Byrne <daniel1.byrne@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] io_uring: don't sleep on a claimed DEFER_TASKRUN wakeup
Date: Wed, 28 Oct 2026 06:30:40 -0700
Message-ID: <20261028133040.1833849-1-daniel1.byrne@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <23ea58c1-0692-4f11-80d1-8845971902be@kernel.dk>
References: <23ea58c1-0692-4f11-80d1-8845971902be@kernel.dk>
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

On Mon, 19 Oct 2026 13:05:07 -0600, Jens Axboe wrote:
> This should already be fixed by proper ordering in my
> for-7.4/io_uring branch - see:
>
> 8257f6ec45ee ("io_uring: don't lose the DEFER_TASKRUN wake up")
>
> and
>
> 76a82c666abf ("io_uring/cancel: rearm local work wake up before sleep")
>
> Please take a look and see if you agree.

Yes, those two fix it. Setting the state before the count is
published removes the window my patch detected, and the re-arm after
prepare_to_wait() closes the cancel path the same way.

My prototype that found this polls DMA device completions in
TASK_RUNNING between the arm and the sleep. I added a test udelay(100)
in every 64th io_req_local_work_add() between the mpscq push and
the cq_wait_nr claim. As a result, we hit the race on v7.3.
On for-7.4/io_uring, re-arming through io_cq_wait_arm() after its poll,
we ran race free.

Thanks,

Daniel
