Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE41E8826;
	Fri,  4 Sep 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519374; cv=none; b=Vr2VxqN14KZliGHgKyC2qDGbr/61U1GOXWK+oqhNofXKwdiGXzvnvLTMq/Qd6hY8WVePxiYQBDoLkTMfD2Lhr5GOfM7FrYIArBS/+SYrkcXmXKhvY05rlcxxhkCmWV+I1kfP5cPAzlAb9eAMM0isf9n4BKf6iGKCFxLAmLW8mU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519374; c=relaxed/simple;
	bh=X8IStrcrbOsDOQVw1398eZtTDU0M7L2uOYS8xBgjrlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DNGOcg3FFdZGWJ38EPM3jkn7Qeq7b00WDBfh1Hvmt8tStJBoIHRxDBbWNkgkGpMxSAx7CMI3cIzG4lS55nCOT+TuZ5uCtCqUjuXhgqG6r/ZQy5E4AFn80+/kyJteredYBH1TgJi05Y+BG/EDFhKpu36VG5PeOeRMX3RmRtaO1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9l28uca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9l28uca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027051F00A3D;
	Fri,  4 Sep 2026 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519373;
	bh=KHk55JxnZIaPiswtVevvFyT4Q+4/zllWsPfgyt53b4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=L9l28ucaw5Or3Tp0q0qTbDXMc8x59HbCxZw3SLV0SYioAbQL7r6g7yS9lFzVF20K7
	 UqqRJDXw91Ix4OccrEI1UOJt+pqxjxuYTmuTNUyMYeovg5ZsqBZxKt7oEBy/nRi1PU
	 FpBtBW3Sa0EB2s1lqfcqg8aO7nuYha3al//BEF0pFuhsfdjLG/g4X3EYX/gjq4jNsq
	 2DUNbFM7GNg1rH11hsMMfPxuDa9yn+o9kBGfdNOCWsLVbIm9gBMhCga/xloZe30Wss
	 DWr8WsVtWghsWmfGbApFz32Q/0cIebpaKNmrH5D2amhxVmgfgRo1e6tWscGaPuqrEC
	 9uwADYSlXnQFA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260903002100.34822-1-kmehltretter@gmail.com>
References: <20260903002100.34822-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] fs_pin: publish pins with RCU list helpers
Message-Id: <20260904-gebilde-subkultur-befugnis-3f28d5b5e127@brauner>
Date: Fri, 04 Sep 2026 12:56:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X8IStrcrbOsDOQVw1398eZtTDU0M7L2uOYS8xBgjrlM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWnzy8HPFmrKaAzUGHjtYKryOV8t/erT076Nb9WlbZ
 2yeIXmCp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAinH2MDPdq8qILPE/djHQ5
 wRC54/4O/q32UcnHlkx/f+JkVPG+g8cY/tmUL9A8/+XBofqNXs7XLJasZptjKJAcc/BtoVr375t
 i/qwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 03 Sep 2026 02:21:00 +0200, Karl Mehltretter wrote:
> fs_pin: publish pins with RCU list helpers

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] fs_pin: publish pins with RCU list helpers
      https://git.kernel.org/vfs/vfs/c/8d01d6b4c17c

