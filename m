Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965A30DD30
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465589; cv=none; b=Wr5ZxE9Bko14YOkoek1kOOCcCcZIKz5EWghSUW9R/rB1WxstL4DtznORtKYS/akrSZe6me8lB/r38BZ7KYionOr8CmjTNGHJiOF25O7kJQFCb3ofD1wzZxrQkerxeEaMk+e7qFbLertjG8cpgdSurmu9WViZBZxJ0oYY68uez9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465589; c=relaxed/simple;
	bh=4iClEmXfd9f/donTnzcdOPwuI9kzucEQKKigKMZSmc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw3TSOlJ+lTcL7mk+nNusXkdCii+uTTAHRXR//603XJ3jhZwXi2RNTF/etG8OLHzDI5Es0NAzHNhLk+pWDYHMv3XEGMuL60MnCqP3n3PHYsvyfmhyj+0Xj2MFip83mh1s6lW9JyBiMs/XyKYBNWfpCUS2Scnp8PkxIfdR8M2v9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICUVcbIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICUVcbIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870191F000E9;
	Fri, 31 Jul 2026 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465588;
	bh=oZ0ACyM3WLFcLRNR7Ba7BZTcXMmyK8ohOZKnR6j2CpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICUVcbIPsJc3p/VC66ZC9/GZBv3GGvZwswW9reSX+uBHHLDusoBKqpyo33XTPTtIX
	 oOaYytMGekWNdcs2t5rmGKxVHDOR1tW0KRphUgc4lVZppZ9HatdUw7mZpc5FapHU3Y
	 YQryRnHmVCSdkRr+lz2k6+kkTV4aHYgQag0rD3On3jalcTiugUXynC7OQduZnUDuq6
	 NecXoH0EBwoDOdQBfQmE6qoclYhFiw3/LK6lWcYA/yAe85lF0zjgxbDOQkR6hrjTl0
	 UkDWXPqkDx5ZoDnSh29SfUDwGCxxirlDqtie1Q6hPNf34MhkmhbLUScz6Yz3puiApg
	 f7UCdSQ8l80CQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	yi1tang.yang@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths" failed to apply to 6.1-stable tree
Date: Thu, 30 Jul 2026 22:39:40 -0400
Message-ID: <20260730203600.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <818fbace-d4be-4ae3-937c-5cf95713886d@kernel.dk>
References: <d9ec68af-793d-41f4-9b9c-d68b1cd51200@kernel.dk> <20260729223316.stable-0027@kernel.org> <818fbace-d4be-4ae3-937c-5cf95713886d@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 04:29:32AM -0600, Jens Axboe wrote:
>> Could you resend the 6.1 version?
>
>Here it is.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
