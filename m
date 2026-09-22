Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD539DBC9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090076; cv=none; b=ULZa/faHJkoo/5rUvEritY1pe44ACGmiuDgO8yXLoAEJPI5UGp5hzpmykA2GtJkYmxcahLpuNqFfXCI1EPgsaCSesiK257sYyiMvveixpkZRTuZQIlbtIcWYr1f7h5L4SGysHSnNeY7Uyy/O6pUeQrsuWqtfyTwrqEDWTYDBY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090076; c=relaxed/simple;
	bh=ilPk2BkcjqcmPcwQopKDsCU0MU82rPpjGM+XHkQOrLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bqYdd6isc60BhCi64/qikHdiN9rYlD2z2+zCVaaLoZK67qkEqfaYP/6u+aKS1T+EBkjRtfRU890msunrQE01me1zUbpyVPD8MTnyyHZ9fkProYcOJWdqN121+pUG4uZ6mH7trXRKSobDro/AVU6qt3890e65dzIhFWt7Np2EQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wk6A14ak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wk6A14ak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B571F1F00893;
	Tue, 22 Sep 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090075;
	bh=WWF9u5AmITpizN//ktnFVoi3o+cFRn1ZP26W1GRlHlI=;
	h=Subject:To:Cc:From:Date;
	b=wk6A14ak4CfTlxuJbEnSDPQC02qzS4JOkSXIVAQyd4uFrGzt1dcQH0v8tAdrJ7z70
	 V/tSDz1EZFKDOlKzKlc2Zl5l2isjgY3rAbpuGMIAlxRMZlpK5nWAjiWorgXS1TwtFf
	 ZzZmX4RcD3f64YnBZijyPNF/3Io59u5CDUDZ6oGI=
Subject: FAILED: patch "[PATCH] smb: client: fix missing lower-bound check on DFS referral" failed to apply to 5.15-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:08:29 +0200
Message-ID: <2026092229-hypertext-grunge-945c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e83330c55edc0c3ac08aa6c95e49e4694c65523b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092229-hypertext-grunge-945c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e83330c55edc0c3ac08aa6c95e49e4694c65523b Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:55 -0500
Subject: [PATCH] smb: client: fix missing lower-bound check on DFS referral
 string offsets

parse_dfs_referrals() checks that DfsPathOffset and NetworkAddressOffset
do not exceed the buffer end, but fails to check that they don't point
inside the referral header itself.

If a server provides an offset smaller than
sizeof(struct dfs_referral_level_3), the derived string pointer overlaps
with the struct fields, causing cifs_strndup_from_utf16() to interpret
header data as UTF-16 strings.

Fix this by enforcing that string offsets are at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 945194fe7a97..05168284f205 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -788,7 +788,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
-		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->DfsPathOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: DfsPathOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->DfsPathOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
@@ -802,7 +806,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
-		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->NetworkAddressOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: NetworkAddressOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->NetworkAddressOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}

