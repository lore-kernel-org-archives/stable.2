Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D1367280;
	Thu,  1 Oct 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862756; cv=none; b=RwqKoQeu5SukpTQ6HlCkz0a7QgLI8lnCGpIeBy2pftmtKLoJdQXnwzcHFpvvfnNk7yVTt2hpeyRmjfiUYXnZ0RzFUiUIovG9I3w7SK+WR3tO5bHgiaAI3nPRNodK7hTIJfElPVRl7oJedbymTrvISH8ZIjBswC3UD1vGCp/uWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862756; c=relaxed/simple;
	bh=rWerf6L7TDR5r+sCglOyf72588H5ja10HSq67EEdFs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7aVQ13266kL+Gh1GyJYsj1luTcC4CiPX/CWE1oBRBdmwYuhhiAo03vO0gFZyHhT1QAcQ+tCe9zqC+fCG1cV9ii8BSTz0WeG0Y1tYGJdNEzcX1G6bA2Ulq8clxVMYLOXpMqHQdl6nOofCliz6dY2gIv9I2cAUe5ybEhKBGOMDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+awJ3Po; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+awJ3Po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245B91F0089C;
	Thu,  1 Oct 2026 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862752;
	bh=ysozL8j3RaQHKUi4WKD6H7KVo1Lv1vH6cRxZAG5gryQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+awJ3Poy72gcE7gS1FbUEtxLyAzYuwO00RBtZVxN0C9xwgkNcBhrEZfLrzsUYIiS
	 W61GKuG6lSTR3xnVTlVZ1sXjLeVEDcJh+bmFtzlEhT476FpFqvNSGzbv7LKZzFbiT0
	 d+LmTReGjcB6ySh8Sxw4ilIDgiXvs8ZwXv/T0Jn6GU+jdzBI65d7sBL0jwgP9qo59B
	 vJOB9oqerah3y0BY2lPuwgAvSBNSMrhSDDu52kRBAdjCbRPoXutdnZ+h3mrAu3brly
	 CybtMh31HA7sCmF+LE5qLOPCa0rKSDb6sI9w0j9OKz/s5VlXC+ibkGRIMV49lgdh8K
	 KjxyYrIl57AxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Date: Thu,  1 Oct 2026 09:52:09 -0400
Message-ID: <2026-09-30-1-daily-reply-0005-amd-zen4-vmload-vmsave-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930024647.96625-1-artem@trailofbits.com>
References: <20260930024647.96625-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-53114. It clears virtualized VMLOAD/VMSAVE on
> affected Zen 4 client models.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
