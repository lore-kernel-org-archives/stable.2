Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F333368AB
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007240; cv=none; b=XNTGv60gtLyhFF9uzVg5AAOnb6e4KDqIZqH80dhOnzJZdDlCYyYDRmr1BU4nBsbZQXK58VkCCK2r6lIaIV75JySTkrTEoL5Kp0G8zN+fvEk3JS8OkitrY0r4vUduj1q+ywKGs1chhJizdiZrk8T5Vpqc4AXnOlXZW7T6RznVjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007240; c=relaxed/simple;
	bh=0JXjyJc4nL2iz30A76Y4QSaMt0jLkEASfnbH3C2O6Cc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BA1nwsoP1P6qagNxaHZNq4wkttwLTWdZbqjcsdqhbDnClKVj+e9zoo2qjs38TYIKLzOexb0MIpbNAg+e73eH/JolYJXbSODWlc0YaarHnO8LMIYgH57c30Z5RoFO8qyPs8BQZPn0743DYz92M6kV5lV9ZkZPtuE68wuWqprKZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d4qIYwiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d4qIYwiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98E1F000E9;
	Thu,  2 Jul 2026 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783007238;
	bh=uqrxZRrH1KeNtgzxlO9DzD5yFJ2EMukwwAZRjwHNmEc=;
	h=Subject:To:Cc:From:Date;
	b=d4qIYwiH3DXAJTZD4tm7slHYD/xbaBsb/uQ/tJx3VPzTGJlqcdmx+Skd/cmB4x3s5
	 GLpVBnArpMCAhImx6CXnxHOaFzRfgyZ0xI+6E/iZaQk0JomHh5H8282AL5n6R+sWME
	 +wQVihplbTMzygxbVoYWEU23yKexkveIva5w1fZo=
Subject: FAILED: patch "[PATCH] apparmor: advertise the tcp fast open fix is applied" failed to apply to 6.6-stable tree
To: john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 17:47:18 +0200
Message-ID: <2026070217-plentiful-create-ce90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070217-plentiful-create-ce90@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8 Mon Sep 17 00:00:00 2001
From: John Johansen <john.johansen@canonical.com>
Date: Mon, 22 Jun 2026 16:34:13 -0700
Subject: [PATCH] apparmor: advertise the tcp fast open fix is applied

The fix for tcp-fast-open ensures that the connect permission is being
mediated correctly but it didn't add an artifact to the feature set to
advertise the fix is available. Add an artifact so that the test suite
can identify if the fix has not been properly applied or a new
unexpected regression has occurred.

Fixes: 4d587cd8a7215 ("apparmor: mediate the implicit connect of TCP fast open sendmsg")
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index df9cb7c00cac..cf590dd08540 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -22,12 +22,14 @@
 
 struct aa_sfs_entry aa_sfs_entry_network[] = {
 	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
 	{ }
 };
 
 struct aa_sfs_entry aa_sfs_entry_networkv9[] = {
 	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
 	AA_SFS_FILE_BOOLEAN("af_unix",	1),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
 	{ }
 };
 

