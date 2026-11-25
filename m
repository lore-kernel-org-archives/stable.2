Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602823;
	b=114uzIv/ymyHusidR0knor0xvL7zIYxLL1bvnuvS9afHJJCOg1sNgBf40HPzsZD+iAmf
	 BkLNYkAMalirBPBjfr49rQQ58E3ZXIpkG79PIOFYjTKSaIaPKq7NVK9qA1f/zjKd8nQ3G
	 /6Qj/W5JYNdPzTZslve2+nAY+RKHvrUWReJ76hpdp6dF9VYj7KTTWZSfncS0jk+ao0SqB
	 IWEzWMPW7r/CPs96LTVHroIKhQDHzg4kz5hq15W1z9OCOHU16jSCuyVMJNrjaSKtICDb0
	 S1RhoYMDmZQzwqmAumB38a3cP5+7joQ+sSG7J+rYrwvvswIPYGHw9QD8OCOPbhAdNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602823;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=meu7zb1TmT2d92jDNcOH4aTrBDqC2Bm1TH4rGco+MAU=;
	b=ZyaCkjs/JyhcKGJRBeb5bTCSxxFr8FhoXACZPRyh9vkgLo9IspbeW2pBaK9F4aNyoYDf
	 QBY0D0qPhVjBElQepV4F6rBQllvUkrn/kCS7kbRoyR842vKhLORUKSlMVw8J5GgRxXxRj
	 Hr51peFpN7ytxDvTxhtMRIFQMEHZL4MGHFVLMyiAvKN6Y5DcMJtVngOTRzPkjjFDCjK5r
	 obXRKGofwZP46xNZNQUgTFZzR3bI06JWAT4HMKrD1/MFB5fxxUdy1ODtxbSD6N9oD83Id
	 53wPZMpTE3UhLaZaGH9JogVWvhiTntt4Ic8Oes5d9KkRS+ymyNY7sEkRgk8xzoCAjeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YtDhtqhO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2582606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YtDhtqhO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8573F1F000C0;
	Wed, 25 Nov 2026 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602823;
	bh=meu7zb1TmT2d92jDNcOH4aTrBDqC2Bm1TH4rGco+MAU=;
	h=Subject:To:Cc:From:Date;
	b=YtDhtqhOWJcWhGYF8gBDiy9StSKOagVY3qK9ol/ndZE7h5gFhxgZ63rTbiJs41n62
	 6bYaVG9g6YO3UBRC7PzxMuLMIBQXt4aCvOn6bscXZBUaQf10x6NXlfASBCXgoIPYdZ
	 r/C8xqHhlKGOLPZgqqnQBG3W+1KzXaCwiOseDUtA=
Subject: FAILED: patch "[PATCH] tpm: flush timeout work outside buffer_mutex to avoid" failed to apply to 6.6-stable tree
To: hj351016@gmail.com,jarkko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:29 +0100
Message-ID: <2026112529-venus-variably-0981@gregkh>
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
git cherry-pick -x c22052a012698ce56d599d75b669d55778521c7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-venus-variably-0981@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c22052a012698ce56d599d75b669d55778521c7c Mon Sep 17 00:00:00 2001
From: Hyunjung Ko <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 01:58:12 +0900
Subject: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid
 deadlock

tpm_common_read() calls flush_work(&priv->timeout_work) under
priv->buffer_mutex, but tpm_timeout_work() also takes buffer_mutex, so a
running timeout work deadlocks the flush. Flush after unlocking; the timer
is deleted under the lock, so no new work can be queued.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261108165812.676876-1-hj351016@gmail.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 6569212dc6b8..ee91f456f975 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 {
 	struct file_priv *priv = file->private_data;
 	ssize_t ret_size = 0;
+	bool flush = false;
 	int rc;
 
 	if (!size)
@@ -164,9 +165,18 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	if (!priv->response_length) {
 		*off = 0;
 		timer_delete_sync(&priv->user_read_timer);
-		flush_work(&priv->timeout_work);
+		flush = true;
 	}
 	mutex_unlock(&priv->buffer_mutex);
+
+	/*
+	 * tpm_timeout_work() takes buffer_mutex, so flush it after dropping
+	 * the mutex to avoid a deadlock; the timer is deleted above, so no new
+	 * timeout work can be queued once the mutex is released.
+	 */
+	if (flush)
+		flush_work(&priv->timeout_work);
+
 	return ret_size;
 }
 

