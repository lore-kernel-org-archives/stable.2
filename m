Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC253A0E8E;
	Sun, 19 Jul 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473248; cv=none; b=NwvQu0YJ5ITXOAVtKFev0uA+rHfPrcWzQ4EL9YXIkxZlgjr5fsLkyyLywG2D66XHarbsfM2b0/Z8tMAwkwCOZd316r5VCOc4sE2PxWEXihgkPbdzJKBeEFSqI+BPuKZrwsSjP98k+LvyMihOJQ5AnxqjXb7mRDQ1PkLX0EqrIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473248; c=relaxed/simple;
	bh=pwGMbGsFKHIo/QOq0WYwNYypdVGJ6zpdbimVeczKZ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvJSN1FMPWR/1KpXnGPGgy+GX7CB6S/b6rKQuB0lQCr0Rc94gwKEIEqYQyA0gUsdzYMSVmy3w0hMVxaCiLtVN30TDGnh89yTc4f8xIss64yaCLY7BWglLJEe8ErHlhX/55ZHeGvh5nhWhjZ20qU4at1J6R+YsRY7GGjQ9cY2dZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBlrYXeO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBlrYXeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A061F00A3D;
	Sun, 19 Jul 2026 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473247;
	bh=rCzWimPZ+onC9lTctxP2h8S3r9cHrMbOsnB1/tRqSxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBlrYXeOnY6an9SDy8FHY8o6D2+y1o6C5UP43MYdT4czjXdfeZYaruluaoWwSaJTP
	 BMAG8Cwikv8/XxPfeg0sIOXBBUx9lqLEXvVMbtTbktmx+Bc6zPt+QiJxjJmrYaeVpO
	 5WWatnAm9fcpwYVe42qYuRm76r+NsjevqpOMllcnkYKzD92Wxf9DG4/gClBERN8Urt
	 8c/vBt9IQo2ICcjxWlovAYZeGVwW9LhbdoNpBzK1UnDvLJ2pbdwzEukBHb0GdUZRs7
	 yV0Isy7BanZ0WYhDgz+e0+7QPDD3KMtQZPG8kZYfUW6vpCllqMVHOMJ9V4B6MHa1pi
	 yAJnKBWSHotQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	iommu@lists.linux.dev,
	dheerajkumar.srivastava@amd.com,
	bp@alien8.de,
	Michael.Roth@amd.com,
	linux-coco@lists.linux.dev,
	liam.merwick@oracle.com
Subject: Re: [PATCH linux-6.12.y v1 0/2] Backporting SEV-SNP CVE-2023-20585 to linux-stable
Date: Sun, 19 Jul 2026 11:00:20 -0400
Message-ID: <20260718192718.0006-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717104909.3850331-1-liam.merwick@oracle.com>
References: <20260717104909.3850331-1-liam.merwick@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The upstream commits apply cleanly to linux-7.0.y and linux-6.18.y
> and an AUTOSEL email[2] was sent (but not pulled so far).

Queued the series for 6.12, and picked up the upstream commits for 6.18
as well, thanks.

-- 
Thanks,
Sasha
