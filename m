Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705749;
	b=NAHtUp8bIh0Xe03hXeQ34fp1lX3nE+Px/pZksYpNITMGnuNoe1lpbD8EURv7avMaiyYl
	 vE8dbDrsvOBekcIibSNd6DlGP64hnEOOVgf5N72REmYFNvz3pIM8oIbd3xyKLzTmPbqD/
	 uIklP10w6GUYkweKsoLcj1ZZ/KKmFGqbrl+BB5PuQhtKbbrwUY8N9I1x1mV71L2EUU35H
	 Gz3uhs6hCo4AtaGQqPrm9vhEnGaSHInCVrDoKjqaWBfNg1Q0sxIYcSyISQuh6B9sMRFd0
	 SzwXM6t93Ag8Z6AuRriF5D+N1donFpMsdGXgW1F4BC5khlcwchviQNfRbDNunGlVFbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U+SQNzcTtGr8aKPfOCjXV71oeuvkFosApEG9ZXEcCIw=;
	b=P7lAc+bWx85kSSG3gY/PrsFcHkRVju/lRRVAdEpqgcOiA2F4cjlXKpf+nWPwg0zy7/0h
	 oP2UR1IDONRqZDT8PQzavIjg8zeMFTNKICKQgC9XALo6vTd7uGxjH7RHMvezbZacyZVti
	 w50PRp69SQdmssysCCVavEj/c43vVJ2Vc0s6TJbYkbDkIhr7IXQXk6v4Bnze7UHfuHDgK
	 QRYEAJeUFthcUPcfPO+JY+GvOplrQBayltZR4SeC+nx10puG5OCMmuUbxA+M0GjQJIpaa
	 nfAYJz1tg3welxLT+TpLDPAsCYWyx67MFR8UDvu0Xm++LjkwPbTKFccJJCPwbLHsqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M99zp/CT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09155606A68C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M99zp/CT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC66C1F000EF;
	Thu, 26 Nov 2026 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705748;
	bh=U+SQNzcTtGr8aKPfOCjXV71oeuvkFosApEG9ZXEcCIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M99zp/CTCVuMlGgchGDBkBO0DL6pyITeH9+egN+fn1gx3ScAQGoBBbKiog6j7MnfG
	 eYtJ0aHwh4SK4vrI4BLelrJ2aQIYd8sIAMZa3IBRgDvyJpNfVGWfN7HOddOOvnh0Lq
	 SCF1F9msX8r/3Kf/peTfoaUGfJ5AtxP1FW5DPV6U7QfX8UGKV+NZuRCc/VZEMzL2WG
	 pOeF04NVZDp66nRgS1kjWBenoayqgsKZ7MKmrmY/LvHvzq/cQ3Ju28PmrFtZUPxDzA
	 uzN7NUNKatoXx9CE55P0SA/RM6Ax2VZpeiru8MkGeMA5hWXgevFslJCT6hzY/dFX+e
	 lwa4aFgN3pU0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date: Thu, 26 Nov 2026 10:09:05 -0500
Message-ID: <20261126150859.2240360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112527-revert-unable-e720@gregkh>
References: <2026112527-revert-unable-e720@gregkh>
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

[ Upstream commit 09b2286af617bc6f9480404b565393628f86037d ]

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Cc: Bryan Tan <bryantan@vmware.com>
Cc: Vishnu Dasa <vdasa@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Stable-dep-of: 824a27d391cf ("misc: vmw_vmci: wait for callbacks in event unsubscribe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 +-
 drivers/misc/vmw_vmci/vmci_event.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 172696abce31b..f22b44827e929 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -687,7 +687,7 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 	spin_unlock(&context->lock);
 
 	if (notifier)
-		kvfree_rcu(notifier);
+		kvfree_rcu_mightsleep(notifier);
 
 	vmci_ctx_put(context);
 
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 5c35874671783..89ab9f05b88c5 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -213,7 +213,7 @@ int vmci_event_unsubscribe(u32 sub_id)
 	if (!s)
 		return VMCI_ERROR_NOT_FOUND;
 
-	kvfree_rcu(s);
+	kvfree_rcu_mightsleep(s);
 
 	return VMCI_SUCCESS;
 }
-- 
2.53.0

