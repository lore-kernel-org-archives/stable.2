Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8F3D45F7;
	Sun,  6 Sep 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701634; cv=none; b=uyWbAPAqhQ317GAhpqyuvTIPUb7VFOB8va+2/3k2/EHiZpuBLQnHnWBRcqMpd2u5coN9DJs44Ql1BF3lhCtnMLYW6WAuVNecC4RWGbKH9eJ1xnoLWBml41cCaeFTXlcLYPBrJLha0VqnC2dOOqrsR3RHNeD3jbKw2paXc0Of1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701634; c=relaxed/simple;
	bh=UfLbliUjGMqZPvkbXWCKig00JebTw6JnB9yc1LS/e7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjNahy/sQE7vn1+CTUyUdgQxMetud2pR6YqYtlyxwDbIMvqav2NV80rfNKgRw/cVkkNb2choWgZKERdExRpVi6+s7GwPO5hUqB9NHgvhB93Dak5pJh3rHj3Qk6zsv1ntS4ZJFwLjIXiW5bXLjPqaI7iSde9n80hQw4qEcJJmWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLXlZzqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLXlZzqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6451F00A3A;
	Sun,  6 Sep 2026 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701630;
	bh=8pkOYVrwVHXhCkpMG8il5L9EtCTiCPfCzAOHfsLxM7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLXlZzqMCLRzJEZhucW71l0ImZMFGZ1wl2KJ7lP8FN0ordvZ/26WNTIP5O5mTYtZ+
	 0EHx2ii2W7gZP9Y7yY5xajLIRcKB31AUIOP7x72fyHts9VgF4vME6ptpDHDKYTDhfB
	 hKuhL7xcwKKYJHDoxDsq/ma+ooYUCZ7s1mNSr/pkZrD5j6xNW+h2kl9fABzveXI1Zs
	 kRD/t57hB6jO2lm3fX9o7NL+TUi9cDUnmFkvtIPBHnHN+3HlAEBISVK+L4LUwh5LDL
	 pbFNXKHvsqRP24sS0bwqbXmOe6wbEIDrn5Qe1oXRtwZGqMIIDm5ApNWebwK2rjkJnG
	 3e4L0p0Ko8N2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: Re: [PATCH 6.12.y] netfs: Fix netfs_read_folio() to wait on writeback
Date: Sun,  6 Sep 2026 09:32:55 -0400
Message-ID: <2026-09-05-daily-reply-0025-netfs-read-folio-writeback-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903223438.2312-1-surajjs@amazon.com>
References: <20260903223438.2312-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix netfs_read_folio() to wait for an ongoing writeback to complete so that
> it can trust the dirty flag and whatever is attached to folio->private
> (folio->private may get cleaned up by the collector before it clears the
> writeback flag).
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
