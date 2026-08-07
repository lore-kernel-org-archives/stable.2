Received: from wendelin.gnuher.de (wendelin.gnuher.de [88.198.12.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6A399890
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.12.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113461; cv=none; b=ahf0Mt3bMm0BQuie53PvsBw7nANMlkhlDkClZ1kZOBIb4ULFabJ8zfjSBkLrIx65frmrSKYeu2+R2T0ZyRKjMcfArv6dJZ4qa9wmpwnrNXr0wglODYrTBgCZQooHkSpacqaS7GOqg2FW/TiG3KPq9K9uKeF6xYfyJaZmuCDqJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113461; c=relaxed/simple;
	bh=unbLmP3ht282twpYW0o12G1M+OpgzUYZXn6+o8VS68I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZtF+8Sl36A0EWwWtFiQYx/ROUMtCdubYQPmzVfkR28TLdHJSRKuJHokLYoZrs261JSvSbaSTHnKMepuD7mQZpZxxA41iQk8cDetmzTnRS9qHpsLPI0QRWy/uMCuCWHe5cbTnEMONIQCgK10xVJomlvBNVkv8y0cNyndj5jV3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=merz-ka.de; spf=pass smtp.mailfrom=merz-ka.de; dkim=pass (2048-bit key) header.d=merz-ka.de header.i=@merz-ka.de header.b=4A3h7+W7; arc=none smtp.client-ip=88.198.12.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=merz-ka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merz-ka.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merz-ka.de header.i=@merz-ka.de header.b="4A3h7+W7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merz-ka.de;
	s=20200719; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+mRcFT9omuyo5v+GRFqVcwNNtM+eDVd7mkloinPeAX8=; b=4A3h7+W7CBUieB7Ulo3uh64Ky2
	PgzHA/NtlDOLtPPsdAOfbTa/GjTvOuvJA3MoGcf+fkf/yNpXIrYw2x7bgFi9if6im68n81zaA58/O
	hd7WXkTBJqM+b6K6Fwjg3ciNwMHZE8XBA2X8KKSJt9y7cOIwGuyyujjPdrJAGNSIJGISurlj8+fns
	A7bBbFfTnZUbsueW+Mf2VzcBPpreYjba3g4Btgn4CKl1PVbn9oZukwpAhV/gcmOp0B6eTrFbRID9Q
	STeMcyRJy4bCUYsW/XCSpKv920TFQ3VuU4rZcnVSf6bXkVX/HiZSBsMIHQOCWMjqVpoY/fp7RGiyw
	LpZWpHdw==;
Received: from [109.109.206.29] (port=25586 helo=C-25H12I214949.jacob.local)
	by wendelin.gnuher.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <matthias@merz-ka.de>)
	id 1wsLSP-0000000D3BE-0pqN;
	Fri, 07 Aug 2026 16:21:57 +0200
Date: Fri, 7 Aug 2026 16:21:55 +0200
From: Matthias Merz <linux@merz-ka.de>
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev use-after-free
 in xfrm async resumption")
Message-ID: <anXqAxQBTgPtQSXT@C-25H12I214949.jacob.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Please apply upstream commit 8045c0df98d4 ("xfrm: Fix dev use-after-free
in xfrm async resumption") also to 6.12.y. Stable 7.1.5 contains this in
63a300151999.

It fixes 1c428b038400 ("xfrm: hold dev ref until after transport_finish
NF_HOOK"), which is present in 6.12.y since 6.12.94. On our IPsec
gateways using xfrm interfaces this issue underflows the interface
refcount and hangs unregister_netdevice() on tunnel teardown, rekey or
system shutdown:

  unregister_netdevice: waiting for xfrm-<ifname> to become free. Usage count = -381

This leads to a complete drop of our VPN links after some hours, and
stalls the reboot for a couple of minutes waiting for devices to become
free (I remember waiting 10-15 minutes for the shutdown when remote
rebooting a gateway without physical access)

known affected: 6.12.96 and 6.12.96, known unaffected 6.12.90
Fixed in 7.1.5 via 63a300151999.

Maybe you could also consider having a look at the other longterm
releases, but I have no insight where it might apply.


Thanks,
Matthias Merz

-- 
Bei Linux geht prinzipiell alles-
den Rest nennt man Bugs. Bei Windows geht prinzipiell gar nix-
den Rest nennt man Features.
