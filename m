Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585AE4734CC;
	Thu, 23 Jul 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826687; cv=none; b=jEMhOA6DLgeo/33ljY+3qpywzS+XdWKFx27l6V0xTs9HxvofOoN28LYR9xETuIRk/q1BPZrClTro4z3/ROg4mc6diiCezsyOPmgx00QBXRreOtm7YmeY82yzg5BomNT5FtIoHgpFI9AC/v/64TNQIuzNWUrV4OXY66rmkL18AXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826687; c=relaxed/simple;
	bh=uLjCsRyL6ECw7qzzeSBxM3OsBA/sqWMPK7qS+OZ1faQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dE435Zl/D6c3eAAjZw8+APxee6QUHpbOh5spbFlKH8m0394NvuO2IBRUM0d1khbnXXxOIDBwbyYkxgdJk7N1tJJkcyAqAMJH5FcSgdrKxUHS+GoX5q1zKcofV4UP/1BdvtKdmhEAl6V1Z4njIOP+BcFPclGQtBviiv4VnFkgFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDsLG/zP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDsLG/zP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ABB1F00A3A;
	Thu, 23 Jul 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826679;
	bh=uXp90yDbLlTCr+yUpZjkHrZ3yz305a7ahk5wNSsYKWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LDsLG/zPTBS/wWc/Es8DKFhvZTFNkaNqt8vxWXGn063NV+KsFmU5m1DOEVmZcYbQ8
	 w/qoLjR5kJnqe1FlAFSRSV/++YbQrqcgOzZ25LTrftBVPu+2XNBydp/xiGpKfoTQLx
	 UWdYigggg4n3lPUaZyQOmAAN0qaqvpXjJDOvBopZYXFfyyJHofOhLxKntNcPShZG0v
	 m+V6df57sjdlIAW9/clDjTBaLRJ9E6EffHMsz/ujBFpW0a7AILeziiPN5eGYVk99HZ
	 6SOY/Oy3X0Fq3XXSfKj84f0r+jdlRvP5CJEbHS2x8qKniMRXtvQLitGF+q7N+HqEP+
	 Wdo6VdQ1C1G8A==
Date: Thu, 23 Jul 2026 10:11:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linma@zju.edu.cn, duoming@zju.edu.cn,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: x25: fix use-after-free in x25_kill_by_neigh()
Message-ID: <20260723101101.00b91e89@kernel.org>
In-Reply-To: <20260720202718.13934-1-security@auditcode.ai>
References: <20260720202718.13934-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 22:27:18 +0200 Ibrahim Hashimov wrote:
> Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Another LLM jokey had a faster horse:
see commit 5499e0602d2faafd42c580d25f615903c3fbe11b already in tree
-- 
pw-bot: nap
