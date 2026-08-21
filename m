Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014283F20FC;
	Fri, 21 Aug 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340193; cv=pass; b=oEh0GgIDDkbWPTSpBuLy2S+YwW/a2o9lSKr/XPv6I0BE9cuhUPBVfPSfD82q3tsNDcSWzk3znSl8uUa66klHiVhFuL01PQjHvUNGSNnjuUjUoWAGsB/Su7ZYH28ncrWXx71rt9KgkM0Fgz8MZ5blTy5RIsdndc4pfKOU5ClPqNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340193; c=relaxed/simple;
	bh=a+OmqHoz+56WAK4EZHTDiztgQUS33R2kagA93v0wHgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2ivOxLOHC3QBmE8p3O0Mc2sDkXQNKHrO8wHOLGlJ2Ei0tzOkmkZK5a+NZICPkrX6LTNuxdRj09pT0wCIHQzQtM5h+EoIWWBiKt9ASXLEzLwgtmc+S0+HsJK70XSzXgNP7SqHvax9GIP4TJKQ2f1eE73nkzi3BrdIzfzEs79pko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=L9QhiZ98; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="L9QhiZ98"
ARC-Seal: i=1; a=rsa-sha256; t=1787340152; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dxAl0xTyEjph3VfT5EZUxiEroCzde3FLVZHrOGwlDFSlFBkm8JCCzKl9Y4t3ImQ3SmGyBI2if3/nckUwq3PivXkuEMGezZRjt0VSQTz+n00MLNdLInmRW9DZTPSSmagPZXKtWZyPwDxjKT+wX9WEc6EV41IUDDZlD+r6EUW8K4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787340152; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a+OmqHoz+56WAK4EZHTDiztgQUS33R2kagA93v0wHgI=; 
	b=Z/088s5Y1BapfODW9CXtuwQ5T6dPQg6TpEsl0ZHAhkt7+4U6m/GCVgP6vMW19Wu5dSWQa1qlu+pU89WhVjO7o23HATyOq3t2giI+rldTgybYEQFEzf0GyQSXNz6eDcBtjit8m1uxd/u9pydQEMuWhDSGktXK5dtLIPRAFlOElow=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787340152;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=a+OmqHoz+56WAK4EZHTDiztgQUS33R2kagA93v0wHgI=;
	b=L9QhiZ98tOKnJxtX514I2C9iG7WvZBZ08wPzsuoU9JbvWtAUL43pygaZ5qwVyZ5P
	OjRweEhqek5Z6vYsnoedv+zIV4C/3/nnaeVw1elNzR3B7r3VF2vB3pezjrOjVK4+mNa
	LniFlQbxwJGFGkwhyp2Z/LF9dpqGqpG91KrEGVXk=
Received: by mx.zoho.eu with SMTPS id 1787340149493295.698898550316;
	Fri, 21 Aug 2026 21:22:29 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jiale Yao <yaojiale02@163.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
Date: Fri, 21 Aug 2026 19:21:51 +0000
Message-ID: <20260821192217.725793-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On Sat, Aug 22, 2026 at 01:45:14AM +0800, Chengfeng Ye wrote:
> rfcomm_kill_listener() walks session_list and deletes every session
> without holding rfcomm_mutex.

I agree with that observation but I don't think this race is reachable. I
also could not reproduce the reported splat.

I tested 7.2-rc5 with KASAN and RFCOMM as a module. An open RFCOMM socket
keeps rfcomm.ko pinned so the module cannot be unloaded while connect() is
running. Even with forced unloads and a widened add/drop window, I only
hit execution from freed module text. I never saw a UAF in
rfcomm_session_del().

The splat also looks like it came from a built-in RFCOMM build. The
missing module tag and the way rfcomm_exit() works in that case make the
reported path unlikely.

Could you send the full report and the reproducer? In particular the
"buggy address" block and both full stacks would help. faddr2line on your
vmlinux should also show which traversal the offset points to.

The locking itself is safe but I don't think the changelog currently
describes a reachable race. There may be a more relevant unlocked
session_list access in rfcomm_security_cfm().
