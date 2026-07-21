Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D33A4F23
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644697; cv=none; b=U61MIdN0AW1n+nt2neAV9gmXb3pPtZFhrFsQDKNIYy53cX6ycZ6/1kBqySN5BM9acFJAQgabUewn9/I1UWq+ZCkBgwRT5stYxy/C8RTtWjMNCEojoRn+DyupOlctOyX6HS4nacOT+v78QL8K70Fd+GgL0hcuPDxAx35kqMwq+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644697; c=relaxed/simple;
	bh=zsbX6PFC4653fMmhPuqqCaHSvVQ0i1oVBCiKvE7LYZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SJKFtB0kzIitfeFQi5VgdEUUAwhhD6zJlkWqAAsvkuzzIt0PUT4c3XHDTzazFIfCC0gpht1fU9V9j7I85KR0t59be2IXg3ky1xj+2LA4+rOkihOrd2mbxRRxcr1PFr82e4tKIXRli/Z4Wy6oQP8m9t2siSEl9zrd+5EDMdjxIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkg0u7A9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkg0u7A9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7887C1F000E9;
	Tue, 21 Jul 2026 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644696;
	bh=pydlYCFiI/bGqcNaW6u1tcRPbnwsdB/jEfOVS25zPnk=;
	h=Subject:To:Cc:From:Date;
	b=lkg0u7A9/2MfvF93wIGG1KPuf4evbmtGRifc9u/fAWD66Y5QR1qcYaXDweI4BDLw8
	 b6WWe+qDD86AEYWsUOiOB1Qukry7XWb5Cc3Csc3FkPUWyROJiFtZHQzJMQHYpqL/dH
	 tTp6XS/QhNuY5iUGGEeSbRJovi7TFyFxXPrOSArg=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links" failed to apply to 6.12-stable tree
To: luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:37:58 +0200
Message-ID: <2026072158-wired-pamperer-25c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9d4b01a0bf8d2163ae129c9c537cb0753ad5a2aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072158-wired-pamperer-25c0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d4b01a0bf8d2163ae129c9c537cb0753ad5a2aa Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Thu, 14 Aug 2025 11:57:19 -0400
Subject: [PATCH] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links
 separately

This fixes the likes of hci_conn_num(CIS_LINK) returning the total of
ISO connection which includes BIS_LINK as well, so this splits the
iso_num into each link type and introduces hci_iso_num that can be used
in places where the total number of ISO connection still needs to be
used.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bb30bde6f0e8..6906af7a8f24 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -129,7 +129,9 @@ struct hci_conn_hash {
 	struct list_head list;
 	unsigned int     acl_num;
 	unsigned int     sco_num;
-	unsigned int     iso_num;
+	unsigned int     cis_num;
+	unsigned int     bis_num;
+	unsigned int     pa_num;
 	unsigned int     le_num;
 	unsigned int     le_num_peripheral;
 };
@@ -1014,9 +1016,13 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num++;
 		break;
 	case CIS_LINK:
+		h->cis_num++;
+		break;
 	case BIS_LINK:
+		h->bis_num++;
+		break;
 	case PA_LINK:
-		h->iso_num++;
+		h->pa_num++;
 		break;
 	}
 }
@@ -1042,9 +1048,13 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num--;
 		break;
 	case CIS_LINK:
+		h->cis_num--;
+		break;
 	case BIS_LINK:
+		h->bis_num--;
+		break;
 	case PA_LINK:
-		h->iso_num--;
+		h->pa_num--;
 		break;
 	}
 }
@@ -1061,9 +1071,11 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case ESCO_LINK:
 		return h->sco_num;
 	case CIS_LINK:
+		return h->cis_num;
 	case BIS_LINK:
+		return h->bis_num;
 	case PA_LINK:
-		return h->iso_num;
+		return h->pa_num;
 	default:
 		return 0;
 	}
@@ -1073,7 +1085,15 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->sco_num + c->le_num + c->iso_num;
+	return c->acl_num + c->sco_num + c->le_num + c->cis_num + c->bis_num +
+		c->pa_num;
+}
+
+static inline unsigned int hci_iso_count(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *c = &hdev->conn_hash;
+
+	return c->cis_num + c->bis_num;
 }
 
 static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)

