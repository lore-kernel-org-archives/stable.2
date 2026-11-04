Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817976;
	b=k/xOlk8ygny1CRgFxRNXHIU8j+BhjzEHtTl9mUeWUM9ushJi1/mIQlhB4DseaRMHZMwj
	 O+TpppfPVGiDPpJeiV+wdQmzYCBeZp1nBThTOQMt7ft4+cO2ujmmwFZWMbc7t9WlVDmym
	 zxNN0U3/C9Xu9Ohx1043ZG5aXSJmv1B1FA+ZHMVlszhIwib/fTnwNbWGxTCNNd5dYL+Hw
	 zCH9Cs/j548HZKafYctFsp0rEAQWV6qUXOtE/yUV3iCLM98mrMiCupJw93iLsTCyw98up
	 pUXrTWbZdu3XXRwN+eVbv7nLYlQR3BCXt9c0EO5KkmchwI9kQP1/k2t5DtNDVOqFfUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817976;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=knI+kJgSmUHhN8J3jg59dfzLdr8ixQlTXijbZwL1lL0=;
	b=EFYE1dyGXXFtHHX7w4g/BY2zi37FXo93x0wuPa6YeKlpGHS3TZ8KDLoRwwacakPuHd7S
	 iYZctWwafzQu8zI4zNbBPFEHeuDlKZRoavTaoPIPHzl0HLHPerfXIEywFxSVF14tA3Dut
	 ZFBlEwIq3HT3oZkyhbIvKGXCqNFJyMiMrzvYSlH6TWPAqQMCrxzmFoO5/qblGU2edfR42
	 xbpm9jU3KC/4DTKw7QmCgEHt309MJR8bm3vJK4mGnAZIiLIg+lDNDK8aMgFQkQMG6PWIE
	 QzG4EKtzBSVFWQDGfkEHbAGWyIIlzt50y7S2vF6B17C+D0FSSxcXOHiKIioFDfYGEaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="scs0u/n9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE86606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=scs0u/n9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED14D1F000C1;
	Wed,  4 Nov 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817976;
	bh=knI+kJgSmUHhN8J3jg59dfzLdr8ixQlTXijbZwL1lL0=;
	h=Subject:To:Cc:From:Date;
	b=scs0u/n93kvln2WLnmJNAHxNU01i4Xh9oUlPv2kJIJMyKDDTyK2IH3YDuNnesZrjn
	 d/Zb1zaBCSM7/eXZoqjWhEkhNzA9bZFZbwGicoLwfH5urUp1+lxvTC9dRH5lVXlpmB
	 lUNxGt/zfVAb3etvfMSdYdjv0Y8oBJmHXeWBvVN8=
Subject: FAILED: patch "[PATCH] NFSv4/pnfs: Free the netid when draining a data-server" failed to apply to 6.6-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:46:13 -0500
Message-ID: <2026110413-dean-earmark-902f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a7c8e96d1b9fa327cbdea514d047c8295b28d49a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110413-dean-earmark-902f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7c8e96d1b9fa327cbdea514d047c8295b28d49a Mon Sep 17 00:00:00 2001
From: Benjamin Coddington <ben.coddington@hammerspace.com>
Date: Tue, 15 Sep 2026 08:22:03 -0400
Subject: [PATCH] NFSv4/pnfs: Free the netid when draining a data-server
 address list

nfs4_pnfs_ds_addr_free() releases all three of an address entry's
allocations, but the four sites that drain a decoded list before it
reaches a data server open-code the loop and free only da_remotestr and
the entry, leaking da_netid.  Both layout drivers drain that list when
nfs4_pnfs_ds_add() returned a data server already in the cache, and
again on their error exits.

Lift the drain into nfs4_pnfs_ds_addr_list_free() so an address list has
one owner.  A striping mount reaches the cached case on nearly every
GETDEVICEINFO, since many deviceIDs name the same data servers.

Fixes: 4be78d26810b ("NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 88bc79ec3459..57e0654cd98c 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -177,27 +177,14 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		trace_fl_getdevinfo(server, &pdev->dev_id, dsaddr->ds_list[i]->ds_remotestr);
 
 		/* If DS was already in cache, free ds addrs */
-		while (!list_empty(&dsaddrs)) {
-			da = list_first_entry(&dsaddrs,
-					      struct nfs4_pnfs_ds_addr,
-					      da_node);
-			list_del_init(&da->da_node);
-			kfree(da->da_remotestr);
-			kfree(da);
-		}
+		nfs4_pnfs_ds_addr_list_free(&dsaddrs);
 	}
 
 	folio_put(scratch);
 	return dsaddr;
 
 out_err_drain_dsaddrs:
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs, struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
-		kfree(da->da_remotestr);
-		kfree(da);
-	}
+	nfs4_pnfs_ds_addr_list_free(&dsaddrs);
 out_err_free_deviceid:
 	nfs4_fl_free_deviceid(dsaddr);
 	/* stripe_indicies was part of dsaddr */
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 5c0216bd5fce..6cd3859d4a24 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -159,26 +159,13 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err_drain_dsaddrs;
 
 	/* If DS was already in cache, free ds addrs */
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs,
-				      struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
-		kfree(da->da_remotestr);
-		kfree(da);
-	}
+	nfs4_pnfs_ds_addr_list_free(&dsaddrs);
 
 	folio_put(scratch);
 	return new_ds;
 
 out_err_drain_dsaddrs:
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs, struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
-		kfree(da->da_remotestr);
-		kfree(da);
-	}
+	nfs4_pnfs_ds_addr_list_free(&dsaddrs);
 
 	kfree(ds_versions);
 out_scratch:
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 70d20f779678..5725ea06efc2 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -427,6 +427,7 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
 struct nfs4_pnfs_ds_addr *nfs4_decode_mp_ds_addr(struct net *net,
 						 struct xdr_stream *xdr,
 						 gfp_t gfp_flags);
+void nfs4_pnfs_ds_addr_list_free(struct list_head *dsaddrs);
 void pnfs_layout_mark_request_commit(struct nfs_page *req,
 				     struct pnfs_layout_segment *lseg,
 				     struct nfs_commit_info *cinfo,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 93d63f75a355..5bd014b981bf 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -633,23 +633,28 @@ static void nfs4_pnfs_ds_addr_free(struct nfs4_pnfs_ds_addr *da)
 	kfree(da);
 }
 
-static void destroy_ds(struct nfs4_pnfs_ds *ds)
+void nfs4_pnfs_ds_addr_list_free(struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds_addr *da;
 
+	while (!list_empty(dsaddrs)) {
+		da = list_first_entry(dsaddrs, struct nfs4_pnfs_ds_addr,
+				      da_node);
+		list_del_init(&da->da_node);
+		nfs4_pnfs_ds_addr_free(da);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_addr_list_free);
+
+static void destroy_ds(struct nfs4_pnfs_ds *ds)
+{
 	dprintk("--> %s\n", __func__);
 	ifdebug(FACILITY)
 		print_ds(ds);
 
 	nfs_put_client(ds->ds_clp);
 
-	while (!list_empty(&ds->ds_addrs)) {
-		da = list_first_entry(&ds->ds_addrs,
-				      struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
-		nfs4_pnfs_ds_addr_free(da);
-	}
+	nfs4_pnfs_ds_addr_list_free(&ds->ds_addrs);
 
 	kfree(ds->ds_remotestr);
 	kfree(ds);

