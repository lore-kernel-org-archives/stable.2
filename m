Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113490;
	b=X67EGI/GpUTFNiYf8TkEg6hajJYyYjeZDDXZOJhq42jj12n6seDU83bEXPlfUU6HDVEa
	 k5zsZdsufYTqWxcGPnHNJvth4PX0VHrcK0FcITTgn9HVrkYG8bfKug0HbMLk3EAt7SCri
	 sUYTsDilmCdwtyxQxS9LnOD+CT0Pix+Ai6aA297iqfz8oEQHaoxqAJwEbgJ8YBSknj4L0
	 4Zzpmx3VOAjAzpIweRqbATpO9q/lEcTfopspdsnu9+2dLbMxe10yI+3WTtigAwiqsX4Jk
	 5VT9VGVlTLOIAWJAZBzN8W47exz18h3iqz9J5LG2dj/wf1h/x3tGhVSBTSDwmmHSc/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=idHmBdkYB+pGsb4ciFoRZd8OmfSYmN5C47UdDtDs8Ag=;
	b=oSKWMQkyzwK9MsENhV3yWCvPYa1P2unmHAjbTTYDWC1XRx+jMVsRn2wF6yBbnzSJfD2Q
	 Ih3vz2iwQgFGB1BEtQjhDdj4OGKuzUEeQhB5gf3l+s++nlXWCjHEnagPOVs8IKEVi5oU9
	 YAn6Ldr2+xtnuROIH/kMpT6Ktes7US75WGd3vVqjAD9dy6VtbfeuzG8n0VjH9RiFSotMk
	 TBGM+JwpgBw9AUhKCjwpy37DENeDMPMkqH1GOqVZNQkbhLFFqYLHQmt2Zf3kW5OwsJaMT
	 uUzJyPNVbAf43zS8HO4GUi7iCPsEQXLeuENrfLSXQadBAojJUtpVmbLAhvXoSoPOoIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPJeWiS1;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFC606A32A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AFC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPJeWiS1
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6dcee5a2fa8so1659eaf.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113489; x=1793718289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=idHmBdkYB+pGsb4ciFoRZd8OmfSYmN5C47UdDtDs8Ag=;
        b=wPJeWiS1MqHh+MC1Qy4nsxftqxqYus959w86RlVdZQnsO5f5oh1Py4MCQS/18WhtEd
         0MyW9N/02eePu25tCo/xRE/CKd78CcLihtAzPuMGwG5GTLd2t5bpA3h11IW/lPy3mIok
         AqBcOAXdYKTnTQkFd6jmRfHcFBFnAYfyz1gl6d0E7WYXm5n/xunyXalOQ6FYQS98UWnO
         aT0ZHLIpjdUJyZiH1YGBU6YQqFiS+j1LkfpeG9eec/AXG4PX0J0CTwIFJOdgCHcRozvm
         eoHb0vjgdD4ez2rpVTE4jYD1L0OJhJeHM8XY5ixHC5hFR/zlYMlD8GO7fImsjk/R69ez
         bONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113489; x=1793718289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idHmBdkYB+pGsb4ciFoRZd8OmfSYmN5C47UdDtDs8Ag=;
        b=yBMTPQZt/D7Wt5Xkau6nvwRpjdvE0y7ZgVMeA49daEnNnhjvwUl6ZBePDfApa2rHfZ
         +ge7OiKS4B/og5KM2Jw8Od3tFN/RQD8t5RA5GKl3TIhEigRYFgGjWodB/m6LiUu5dLXS
         zv39Wn9y79AF+uAZO3Tx15/BP3O2exDL5biQieLbBq1MUc1WEyGaX36RJI+Q2eE0yMmo
         iEv+DDaTcD2I6ewisHpnG7pX1uoUJbp1HCLIVIBz8iJ4GRxcKTkfNSDapUCRi2ACEkSq
         FZtRJy/uRTEn2sjZgb48o7dVACXLj9ejOxCzpist0FKLmJZJEattKKS+6zBisIh3wic0
         wfng==
X-Forwarded-Encrypted: i=1; AKwUvBxEyBnyhsvP9bNldh3EVdZGFZxaFMPUi5v829eqvKmhevSpUpSV2jCJHL2Fw9iXD8my7wtsJuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN0DqK2gYmlCzigR/wfZzGo8ZOwkg5mX4iESZm6u97OLF0VWl5
	K6GGGl0Lu4IDV4imapOgNxoM2VP53uw1kVymQFZZRKOGa9TkmnF6x4el
X-Gm-Gg: AYBFou2BboBgBPjNczTmawV76jIl+uGl3fTfZsGBOmK0h0+qd485yzDH90vMjNFfU7E
	MTl29ozUDWe/JoVLSXje75Ot3B21w/w2oLRCmM5Ti2WuPzlVLwGS9y9gP/cEK/zQyhc86gnzqFm
	kFGhB/vzotc/j/VxDgTtB2yLEU/WDQHQAQYD/LBH5HlTnrhq1gW+cw3AipRPYaFU7KMu5wSSExm
	OVjcGc0AWrUGICZBbFIn2A+rDaDjHSzqno6fFX+ULR3DGNYoBvVLzFYnfL7dksBTJBC5cTylc84
	kUJCQnJQ6kUmEcW61ptQvwr8LNGUlrDxV2to137xGXHlTZPh7wC44VTCCsKihI1zVEuyUcTs42K
	gkDMgUr2WIdNmCFsea9IXGE3kkFsTJFOUK1dg63Ip5bPzA0rBI4IJGfMA+hUCeQpaBgVxVFr0C0
	xn0HhGuJDCr5ctPNMiPisdmO0EHXRi38RYONcOr8zsPt30sDnYK+1i5Z+v8H3jxA+LoY5ijbaMF
	wNaBdu+y2bn/0jfvTRgMIPYVmGghvJiC+btlMZ4Q/vmZMhWysCDjcgPPCJo1s3h0Ah8Zv/h1fbH
	kOINk7k6n13fyBBW8g==
X-Received: by 2002:a05:6820:1625:b0:6b4:117e:545 with SMTP id 006d021491bc7-71269638a81mr1504369eaf.13.1793113488681;
        Tue, 27 Oct 2026 08:04:48 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.180])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71278c864b0sm2824416eaf.9.2026.10.27.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:04:47 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cifs: fix UAF read of server->hostname in cifs_get_spnego_key()
Date: Tue, 27 Oct 2026 23:04:38 +0800
Message-ID: <20261027150438.943354-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

cifs_get_spnego_key() reads server->hostname without holding
server->srv_lock (fs/smb/client/cifs_spnego.c):

    const char *hostname = server->hostname;
    ...
    desc_len = ... + strlen(hostname) + ...
    ...
    dp += sprintf(dp, "ver=0x%x;host=%s;", ..., hostname);

while the DFS failover path frees and replaces the hostname under
srv_lock (__reconnect_target_locked(), fs/smb/client/connect.c):

    spin_lock(&server->srv_lock);
    kfree(server->hostname);
    server->hostname = hostname;
    spin_unlock(&server->srv_lock);

The read side runs on the kerberos auth path without the lock, so the
strlen() and the sprintf() can race with the free.

Take a stable copy of the hostname under srv_lock at function entry,
before any use.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 93d5cb517db3 ("cifs: Add support for failover in cifs_reconnect()")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/smb/client/cifs_spnego.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 44c4072756804..488ddf6df138d 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -105,7 +105,15 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	char *description, *dp;
 	size_t desc_len;
 	struct key *spnego_key;
-	const char *hostname = server->hostname;
+	char hostname[CIFS_NI_MAXHOST + 1];
+
+	/* hostname is replaced under srv_lock by the DFS failover path
+	 * (kfree + new assignment); take a stable copy while holding the
+	 * lock so strlen()/sprintf() below cannot race with the free.
+	 */
+	spin_lock(&server->srv_lock);
+	strscpy(hostname, server->hostname, sizeof(hostname));
+	spin_unlock(&server->srv_lock);
 
 	/* length of fields (with semicolons): ver=0xyz ip4=ipaddress
 	   host=hostname sec=mechanism uid=0xFF user=username */
-- 
2.43.7
