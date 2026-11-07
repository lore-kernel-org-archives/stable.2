Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046442;
	b=auDAW8fFtU/7KH0u9Pv0XjPgJBLDKymFQFX+Qi2nxPdsxwVuzKvXgz780BFbL84syX8F
	 S4ByE8Rb+KyEhkAzetn4IBrwS005CPzOwuD0KA2ePgGlwyTKC6kp9Nwm+As1ewk1k8TIb
	 a7Ztaih9vct5ftAldmVV/kCZIi7h27lxXDTCwBZz7sA4I7ghyRNwnm++O5NSGAZWbz+54
	 vi3YSAsZjN78liT01d6AUeVdLJpeJcmAzDb4lA99jn45Rb41qhRecfH+7IhZN9X63O8W8
	 uN9hgHSuvxSqXNuMfsnsjT/orO7anbdQmk982mjtRWRbHh8prelhVJFYMokTJQp0Pkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1jU51aIcEfVUBxWYA17a14tblN2CqmzJ/6cg/ASKZOo=;
	b=kjIJ6FN4nTNhQ8mekAEN51Fju3pBJiUarZGlqI2k+D/vzp5AS1GqQRKUUMCNWMlKPcoA
	 ib8NKvbbwg7rqoqY8RwDreEUb3W+u0JtnSAxyx5Lj5pu1AAH84Uf5AVYhAro60lwf45hs
	 oMWxeXp3K/wBfIsRSSdndXSu1AnL+jxOfKA0MVTOCo5WfY2kTO5o+SmT1HxBNoquySd00
	 FH/Gg+ErcR8KLfTKANTMn6yecJ3AyZCxBRbGsN8EHCc99uajbR+wBVge4t5GbcBjgRvat
	 uUS8uxExjHwSNIhxBXOVK7g2mTBYg7JvkA+GZ4mPK3gGt5fqB6FDR4bM2pzspmNz4+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afL0Bmyy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afL0Bmyy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B279C1F008AB;
	Sat,  7 Nov 2026 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046441;
	bh=1jU51aIcEfVUBxWYA17a14tblN2CqmzJ/6cg/ASKZOo=;
	h=From:To:Cc:Subject:Date;
	b=afL0Bmyyn4QkIuGnXnrICGqcfKjiAxBG4cEIYYM8k2GLxeM/L7USp/SRBjNMgy8vb
	 2V86iLFBSA32xUFPA5oxPKaebixjq8hWPpTbRRWB4G3jzyoiF21BG0sUfcfEgNr57H
	 83LnouHFdIKRZdnhDm/VeAI5Q/E8atTFIwIRar5nW7px9F8Scx30EFpS8vzAaDVE0U
	 cU9trWvNG6Zbfq9gkjrKDgA/uqk9E9Aw0trivseVB/PO9o/n+CleHJVxnYvpwygGXK
	 TxQrbXkpKal8Nrx04KANBuMIpilPXCM/SkjdN6Ypv7znstxCUZBQ9zsDDN7WKKCRMB
	 8rpK8YJqYyc3Q==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:59 -0500
Message-ID: <20261107051359-failed-6.18-1ae42513205a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051359-failed-6.18-1ae42513205a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1ae42513205a38b811afedb6797f9f9c4de37b90 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:54 +0800
Subject: [PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result
 byte

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Reject UIC commands that have the result byte set with -EINVAL.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-5-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0db830e54ef0f..cadde515f040b 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -179,6 +179,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		if (uc.argument2 & MASK_UIC_COMMAND_RESULT) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = ufshcd_send_bsg_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
-- 
2.53.0




