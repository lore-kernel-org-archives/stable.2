Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597521;
	b=fcQiuLfSbqER+1fho3+HAT0cS4gNqX3mVZd1PHHcOZNTXEqF2XnoFaioA8srr0NEZBrq
	 Fy8hnq/NX643OZiuMVGdQcxq3GjdRuK10jl2dXMkAb9+C5/bhVCRoW7jPGl+LjA+IEf3H
	 pZY4yelKj6eNXzCw7EREaZiGqFBn2+HljDCcfBrnbRdN/RH4uYy1qlmEOE6IqGuX2lzrP
	 tCkZ/eJOFOFJDxYRWMrLldz5XRdZFx/isN5Q0Pe/yNzrRhTTjG/Gq3KiLAeQwt2HMFl/S
	 ybefXfmM/of4PsvsH3tBqZ0DGj/6UPgDrYd3VMceqdGV0tpetf4n1QHo4rUfu2mB/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=99nr6QI50LIlQ88wC6Fbs0ELH2VisIZKxL8EMfLU5Tc=;
	b=DY2cAPaWbTeuCgFeSZlAVkUsWLVTp2P6UWMnkIdhSTk7CS50B8OXQo+OPqNv2Z4NV4lz
	 5jk6Xvw6sL8zwWY7vPOnr5rwn9qEwEceoxT+ONgd1ZLk0mPrmu+rpR0PCe/el0GSd4ljA
	 Z59+7JFNcgjrpUVL73Uk6Whm4AIlVCrdNBv9vIaqwpDPryHCTeKnPMOKXHroWwxl518Uw
	 1v5LUChlwiZL6Ly4v/U8Z/qPzzdXzZpQhgrncqOC5OBDMAG3T7Q0cLRzGscRiaO8co87P
	 Tin+O0Go9oAL0qKfi5V/IWusKZjve48Poa3yOiMzxDtvQT0JmwxguRgiD9QKP6GASlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxHZ8ia3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677C606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxHZ8ia3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577481F000C4;
	Fri, 13 Nov 2026 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597521;
	bh=99nr6QI50LIlQ88wC6Fbs0ELH2VisIZKxL8EMfLU5Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxHZ8ia35223jZ7kvO2jmS4qhxtMO3GW/r7qHGlSjPR6SZnCcdQ4EomolZkyDKzHd
	 E/fXd6aB/PdW/B6oXmjuPEIdguYEVLwIrN2yhkiFz7uQEyUh6dZ2Elj4Ys1PLwQe5O
	 t+kQVeTHHOGpOX03gYbgrBdq0g+RG3m3+wuOyNw/mHhwyuWX+sSfdlRUhy1WkQ7O5Q
	 fsCLVoVCB9rDGDhIRPz0E8kr8EXkgsCI2j7hmxHCa7jjrM98xXQgNUv2hXGC3xEQsf
	 XzcLqPI293e9EBiZFD33RxC2iRSwkZ8XlLKbSz8trNWZ+IMjOo+QmjctMU8cAh9jpU
	 Tb2HuJfej9Phg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 14:18:39 -0500
Message-ID: <20261113191807.2276968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202349-failed-5.15-b1ee87802111@kernel.org>
References: <20261109202349-failed-5.15-b1ee87802111@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit b1ee87802111156e27557e82acc31fa7dfc76e2a ]

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-44-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: replaced vma_test() with a direct vm_flags check for VM_ACCOUNT ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3737febcb8768..a315134dcdfec 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2373,7 +2373,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if ((vma->vm_flags & VM_ACCOUNT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;
-- 
2.53.0

