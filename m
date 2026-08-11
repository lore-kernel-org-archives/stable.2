Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADF2E1F06;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454450; cv=none; b=Ouw8vvauHApanUZBjygRyhmEg6e+nFSOkY7+np/Sd/bf5gZqrU8HEbIdiavjgo4DR4Nrpoo+psAJ1niK23dHGKYEgd0GXjOZr+lrsvRRnf8Y9POMmMvbHruuOU2DijJ/FJrB+oabkb9LJxXT2HK+m62IonnWzQYKX0rU4QGZ+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454450; c=relaxed/simple;
	bh=X7wTZaxrYAAokBPf4nHKY5fuDPypAvFbB1h3EDD04FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gp/QI+b7VN5aySpl7wTy5uS0ZiwtyDieix8UFbQxYhlwIFVV58E146nheojIw8sDKJOf/FnDSxheYoD4mLs5JOS8I7osV9Hqu/3wUi0kWf7TKXTKhY/VK2UT8XbkGdLfn0CjWujE2TNAxXNwLb/h4WMDHUH/rXZDyloLqUTM6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBmoc1hb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBmoc1hb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A44D6C2BCF7;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786454449;
	bh=X7wTZaxrYAAokBPf4nHKY5fuDPypAvFbB1h3EDD04FY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aBmoc1hbqWnwc59NRd2lbTnPlBZcODucyEDr/B5Q5WhVFKk/ndQLGpahJOErN3cMn
	 o0GospP2OhzcGni04FsxgLXYsf1B6sL/kk6SW2WawkMNGLfIvw9I/ssgMJf1hH5ugd
	 /zsaBx1Pnh6eZPG/0139PNvk3NfOHEBzYrAyK0UPczqAJamyfFZLGl2PUijLIKlK3J
	 lBjXrKox3aU8xidmFXtshst4Ju7+IzvXFqtOANFk41DgIimYFhngHV0qu209ZFIyjH
	 9+RS0Bxjd8Dt8aAA0RvXNshhI8CA/uDu/at8HlOnQicjY+WeSZ6Ipcx6Hqym8tdy5Q
	 m/5iIyUl0k4Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168CC5AC67;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Date: Tue, 11 Aug 2026 13:20:49 +0000
Subject: [PATCH net v3 1/2] net: thunderbolt: Release the Rx HopID that was
 handed out on mismatch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-tbnet-hopid-v3-1-9e75d1b51331@gmail.com>
References: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
In-Reply-To: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Fan Ye <fy15309206903@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786454448; l=2078;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=lESY9+I3jf4v1krnmOpqlJtStY5pn7YDNxvIAIgBURM=;
 b=l+k7+Gl4blEYewjBjyTKIRvXUm48/QslNgv9EF7v35WCJDO56STd65s/Go5ugXdYV5puJ/en5
 qn0F4sPV6vvDEAMEf/OgijEX/otAR7oGAuI1NaXr5C+9f6OOW/VHQk1
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

From: Fan Ye <fy15309206903@gmail.com>

tb_xdomain_alloc_in_hopid() passes the wanted HopID to ida_alloc_range()
as the lower bound, so a taken id is not an error there: the allocator
returns the next free one above it. tbnet_connected_work() asks for the
peer's transmit path, treats any other id as a failure and returns
without releasing what it got, so that allocation stays live for the rest
of the XDomain connection with nothing left holding a reference to it.

Release the id when it is not the one we asked for, the same way the
error unwind at the end of the function releases the expected one.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Reached without fault injection on an ASMedia ASM4242 host-to-host link
when the peer drops out mid bring-up: 23 times across two hosts in one
run of interface down/up cycling. Each one ended in the XDomain
connection being rebuilt, which recreates the ida and disposes of the
leaked id, so what I am claiming here is the leak, not a symptom.

Patch 2/2 edits the lines this one adds and will not apply without it.

v3:
- Rewrote the commit message; dropped the quoted source and probe output.

v2: https://lore.kernel.org/netdev/20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com/
---
 drivers/net/thunderbolt/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 98893732bc6e..e5199a87ea7a 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -647,6 +647,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 

-- 
2.43.0


