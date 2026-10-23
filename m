Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792730414;
	b=UjanvOva1FuArBup77/MYjLsyZOTz2VKylMG3TJgeyYGR1z6kAff6+Lj6+J2X499Ieet
	 1I0wIaXmsh1FdEqZWYtNCJIEHoBP+lk1zqgyFzRl3XC8ZjuSWK66CpAjJjBAfn2Z+u0cy
	 xLDPDg3DR3lDzElms9486GOL4xUT0/7XGvQALzrTs9ja2sqeRO2ITUL8d+AUesJiR28sC
	 8MzVgWdzqG82hJIoHZJ09SpICOUuSi+3L/gEdIYFQwM9mM8Dnv8Qjh5JDPWAMVoX9kT2Z
	 HikzN7eDIbdG0Ifj9Jzavhlqg1L1U1nHp8HI4+KHvlscS/InKKFo9VzsnzW720SZppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792730414;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=h8PYakhuKVSQcTwaT3dKpBy1nnOIFlM8kyn1oh0ZAYw=;
	b=TnUkbfnHMMWA+Ve467nkSyooye1pZ7fprfZaAzS/lgrH02guWn8rvZJALy7OtKB5oWLj
	 5GzL7dyxC67vLx1yh+WHCvmdBmbWlbqM0W+RZTILECSXNJ8VF5duGm2quoeNz4C4MVxtj
	 G0eOgdhrz3ECYBQtmRQHIaUjz2to+id8FFVXqFWkZpx20O49R297KI/xgdPepQKzDPW+b
	 2ZG861/PhJvZWotrw6n1FsfLkTQT2Endo0fPWieCo+PyCMsDGAvCyOlLwjO6+BKwKmf9r
	 mLEHPGoD3gOSIyOlkw37zK/xIWaogI5rodA0p6ExF6NHgP56oHIjxAjox9sLsEhzufg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=ZiUhgpBC;
	arc=none smtp.remote-ip=210.130.202.152
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C50606A319
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C50606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=ZiUhgpBC
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1792730381;x=1793939981;bh=TOFZXo9O7IpTOKlwN3uJxWq2i7HDYiOKPXHOC5dkBHs=;b=ZiU
	hgpBC1Z4xfp4esRfYLIGIvkzi9NisAyFhCFVsp44oWnkcpjBBn+iqnNOXwlYeGmImSl41q3sbH8tk
	jLquds1AphA6R8t/U+fCrlGQ1RMEMk/ld0PW9mgkPV51fIZJPhXgF9QozU49UMii5Xn5nhZA1nNLD
	o+M6OgcIqzDO6bRiNOB2iAkzW+kCbp7x8pMBHA71vVh7nTeJ4RN7EJcImbUihqHmuPX7FVJRz1E8Y
	vybtcMQR6+8SMEm8HSHiDk8PaVUIt0k0AotlRuo9f73KNPQG4CP7TDCRb6wJkyPh5U8KryTjNNR3y
	IbiK8RGeKxzFCHvHpZ/IE7RXXm+bcNw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69N4deY23015997; Fri, 23 Oct 2026 13:39:40 +0900
X-Iguazu-Qid: 2yAac6huv2kV28r2F9
X-Iguazu-QSIG: v=2; s=1; t=1792730379; q=2yAac6huv2kV28r2F9; m=lviR9/8xVnH7OTFf1xc0WxEiQE7b/j7tOIkOFr9QrSM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j9r0C20Ffz1xnh; Fri, 23 Oct 2026 13:39:38 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1] fs/9p: fix NULL pointer dereference on mkdir
Date: Fri, 23 Oct 2026 13:39:31 +0900
X-TSB-HOP2: ON
Message-Id: <1792730371-21640-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Christian Schoenebeck <linux_oss@crudebyte.com>

commit 3f61ac7c65bdb26accb52f9db66313597e759821 upstream.

When a 9p tree was mounted with option 'posixacl', parent directory had a
default ACL set for its subdirectories, e.g.:

  setfacl -m default:group:simpsons:rwx parentdir

then creating a subdirectory crashed 9p client, as v9fs_fid_add() call in
function v9fs_vfs_mkdir_dotl() sets the passed 'fid' pointer to NULL
(since dafbe689736) even though the subsequent v9fs_set_create_acl() call
expects a valid non-NULL 'fid' pointer:

  [   37.273191] BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  [   37.322338] Call Trace:
  [   37.323043]  <TASK>
  [   37.323621] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
  [   37.324448] ? page_fault_oops (arch/x86/mm/fault.c:714)
  [   37.325532] ? search_module_extables (kernel/module/main.c:3733)
  [   37.326742] ? p9_client_walk (net/9p/client.c:1165) 9pnet
  [   37.328006] ? search_bpf_extables (kernel/bpf/core.c:804)
  [   37.329142] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:686 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538)
  [   37.330196] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574)
  [   37.331330] ? p9_client_walk (net/9p/client.c:1165) 9pnet
  [   37.332562] ? v9fs_fid_xattr_get (fs/9p/xattr.c:30) 9p
  [   37.333824] v9fs_fid_xattr_set (fs/9p/fid.h:23 fs/9p/xattr.c:121) 9p
  [   37.335077] v9fs_set_acl (fs/9p/acl.c:276) 9p
  [   37.336112] v9fs_set_create_acl (fs/9p/acl.c:307) 9p
  [   37.337326] v9fs_vfs_mkdir_dotl (fs/9p/vfs_inode_dotl.c:411) 9p
  [   37.338590] vfs_mkdir (fs/namei.c:4313)
  [   37.339535] do_mkdirat (fs/namei.c:4336)
  [   37.340465] __x64_sys_mkdir (fs/namei.c:4354)
  [   37.341455] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  [   37.342447] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fix this by simply swapping the sequence of these two calls in
v9fs_vfs_mkdir_dotl(), i.e. calling v9fs_set_create_acl() before
v9fs_fid_add().

Fixes: dafbe689736f ("9p fid refcount: cleanup p9_fid_put calls")
Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com
Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index e15ad46833e05d..7c261b354379ab 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -424,8 +424,8 @@ static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
 				 err);
 			goto error;
 		}
-		v9fs_fid_add(dentry, &fid);
 		v9fs_set_create_acl(inode, fid, dacl, pacl);
+		v9fs_fid_add(dentry, &fid);
 		d_instantiate(dentry, inode);
 		err = 0;
 	} else {
-- 
2.55.0


