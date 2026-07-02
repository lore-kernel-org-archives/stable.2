Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8123B61B;
	Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=q8MH9dE6KzQXPrUTo244bMUUN/wa52CoFWNVFBsfTAV12vYrPtG4xZJEfCVcYfBBbOYcsD0K97bs6hfxxFLxHtoiDiypJwQd9R7yCQWY9g+E/0cYigkQnZG5vgN9oXxnGp71RgJRbRcmQaxLVsjbhVeJUchdZbFTN1SE3DM/YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=4FEbMQDgH8S/wK4vw6nNRjwLCjNCpuBt0+xHmiav6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPMMunQ7RezE6t0bfCgseVsIF59MfyTkNJnsGjoEU0AD5JkF2r4jFzj3KG5tIv5mGwfznsbnBySTmSMFidI2gHvPPT0xhEF7QzJFkrLULgOZdhvEnG5pE1zPgYax5jtVNJSpzZ9JJKpYcqgeznJoVLhXTPsm83u0papLZf+Nxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLasALrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLasALrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A691F00A3D;
	Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952725;
	bh=g23Smlgv36tz/nRKQRwM2wZEV9ZS31aK9ItwDzqu71Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLasALrAikS46IGhf1IHRhYiVYrlA1ThCPGZSHp3xCK6lTe2uimRj82mso70chRMW
	 yNDIr0FUaGMsC7OMVGfH7vcWDkjvoI1iHFubmiTCZzjhHo8vDA4OSehg1Wi5X3gEhj
	 Os/6BcciiNHpNtwbz+1cQ+K501BwkKuz8O7CxA3HuMlqUR25gjelR1z+LG1cwTlHUL
	 azAXWvRAoSn374/E9VkUiGZ82j9ihAVsPGxBa+8jLzcfFDSaJ+vBLV9K11G62L4q5j
	 fRDDzR/VlaOkc1x19nK1CYdqfnVSixsrGPK5V9IlEyN1JImQGIY/TrmX0N0049Bciw
	 Vd4K5fCcykGIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Wed,  1 Jul 2026 20:38:28 -0400
Message-ID: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701134933.66838-1-lulie@linux.alibaba.com>
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.

Queued for 6.6.y, thanks.

One follow-up: 6.1.y, 5.15.y, and 5.10.y carry the same unlocked
"queue->state = NVMET_TCP_Q_LIVE" assignment and don't have this fix
either. The upstream Fixes tag (c46a6465bac2) doesn't correspond to a
real mainline commit; the race goes back to the original driver in
872d26a391da ("nvmet-tcp: add NVMe over TCP target driver", v5.0), so
all three older trees are affected. The mainline commit won't pick
cleanly there for the same NVMET_TCP_Q_FAILED reason you adapted for
6.6.

Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
Your 6.6 adaptation looks like it should carry over with minimal
context changes.

-- 
Thanks,
Sasha
