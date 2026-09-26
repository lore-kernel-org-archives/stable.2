Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DE35A3B1
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405436; cv=none; b=GnmqZzABSrW0J9Fh9n+s7oh7ulzzYBOZb91YbWmJveopVKDc4cK+CEQOf7YJ4Z3LoVc5A8/1WRtldB9aQDFSJ/4JssgJ3VEHC7+sl3zJhs7zJ+9A+CqHjjIemDqkFZAcdgM5FRZoYcgAU4X/6OGzBDjgRRqn+1zjFyh4hGvijJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405436; c=relaxed/simple;
	bh=HXXQDQFDe6y3nQ/vamf6MNCnBdaQPhLlVMTawKOpJl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXvAAagVPn6z4pZeTrh4HsvZu8V6x4fqNCq3+KdN8Bgowya3noJVwTzeMa3TpLWTyFXwEWWjWicvkLB2u093Zu9Hv5urQHP0gbQGaZQueF3UYm6NFK4fJPdBQzK7ljtHzMFO+7yiXaLvKbc2vUhEpqtHOI9wiGSDdkSdulZAvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KKJcTB+L; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KKJcTB+L"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so698838a91.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790405434; x=1791010234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwLyN45KcXkMlGV64Woz+4zZ99i3stRGQEp+uIa/oYs=;
        b=KKJcTB+LXHmibGJJ8l1Bqq3mYXAP4jyXdZuMimyTM04u+yyqEOTfusm+2t/Xj/OVfN
         4vOZ3e0WLVHnuDgkHMlUwmwdkthIulyoHGsmDjzPIcmNMilG929opSJAXMlrSEvGbKOd
         dz+PBTof1cWGtoh1QUKJs8RuMBAqbDd3ss6Ye4x+qey17O18w6gDRDya2CZMLfjrwHzk
         o2gVYgEngdweL1u/MKB2ym7mGWRpxHd6FCVZMoKl+H7U5laeDH0HlBP0cQIDkY9uyM7e
         X5jcqP3c/ks6TAGv7uH/C1NTen1VLVSsWzKDXWyzHi1ethPQkwcRuryoKqPIP4KUqem9
         ujrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405434; x=1791010234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwLyN45KcXkMlGV64Woz+4zZ99i3stRGQEp+uIa/oYs=;
        b=qT0OxY5JKtYICgyokevMSribmJhlGJBtSHlUWyUNhzRbvxHQD0aBzAe0iTbP6lt1YT
         oV/H8NFPifZOtzCc93I75mUku+Ssuw0sOTtWQDwymGdKiBHnOETvGQfdPPfp7e+CHEz7
         Xn0IUzhlVG/xNmuS6CSTddJF8zrZbBCM/Xd4gSQrTkexYMkrRQcB8be8QOR4Rz8x1v8y
         gved+mvvP4tOI0Fjs+xWRTse3VfDEufoxSBXl4L4Srz2u7hdHMyyW5X/+CjlXPHmwFs4
         xxPVYQOLLepaQL3TQ27Cwq/guoZFLA60s7tsg9OK7n/fkWMZbuTiJrQttKVU5k/QE7oM
         TrTg==
X-Forwarded-Encrypted: i=1; AKwUvBx7PUU3y0HuU888U0nVXSoETWzngDcjFAKVcAf7BYrQ1lXuMiA0XnpXNQ01amgG8/Q9R/PKqDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6UnvgUSwB6eVJUaBnbTHjwEW+SWyHYTNNPMawl6iMcAL5JZGM
	GyelwDObLdDVgTZ6VsVoGBvaQrgos2xrBLJ2rud7RRtwToIpmpRcVPWDjEe+llzYg+bR
X-Gm-Gg: AYBFou2yI3KVzkyyOYp7LbKBWd5zON2FWli1tZ38SbudizdtBcC+D63qGX4bgbGWezn
	36HpayHT+rh4JmGENwGaPXB8NCruk9aq0zBdUCp4ODjUWyZFW4t0M4adwXPNs8WdRjz228SvFSv
	2vLY8fgY2et84dVWJQGe/uZTNeUpKoqBCr3wif2Si25FKT70X/tXMyyf1p1ceW4om27SB+o+IQ+
	3SyP2F2y73qbj4SABf+kZ8xdUUG6c6m6UKJ2IAC60c3p3m0bI5wSUdQuslhymaL0Mm/3qxY92bT
	yvBOIIc/P0KlyNHMZ24WS0ny+zK2IYno3lr9IJQ4vQqBhmHBBeWoxBzQJd3z1X93+TowThIxgZh
	uwem0RG7j+m+yxDVHZTr5+uV0+hBIgpTOrv+rhsfIp1cG2RUFXVh8O51IBCJ1xNDLD4RLnV1lSX
	ArVg60v0IFpvXy5OF/bf4cJOg0wZwS5leU7eZU9wmtirq+m+83zc9f8xrFuRfP7CN32TChRMyCR
	mdCW5CZwk1sxX1oNAbB+zTKl67UgP0=
X-Received: by 2002:a17:90b:2785:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3a09875ee61mr7024834a91.19.1790405433480;
        Fri, 25 Sep 2026 23:50:33 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm3447327a91.0.2026.09.25.23.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:50:32 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: sfrench@samba.org
Cc: zihanx@nebusec.ai,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	pshilovsky@samba.org,
	aaptel@suse.com,
	pali@kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 3/6] smb: client: close handle after create-context parsing failure
Date: Sat, 26 Sep 2026 06:49:23 +0000
Message-ID: <ab085417d625754208dd45f8ab751d4d06f410d8.1790398755.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790398755.git.zihanx@nebusec.ai>
References: <cover.1790398755.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMB2_open() accounts a successful CREATE response as a remote open before
parsing its create contexts.  If smb2_parse_contexts() rejects malformed
context data, SMB2_open() returns without closing the handle, leaving the
server-side handle open and num_remote_opens elevated.

Close the handle after a post-CREATE context parsing failure so the error
path releases the remote resource and balances the open count.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v5:
  - Rerolled the series after fixing a NULL dereference reported by the
    kernel test robot Smatch analysis in patch 5:
    https://lore.kernel.org/r/202609241449.HlHmnZFZ-lkp@intel.com/
  - v4 Link: https://lore.kernel.org/all/cover.1789478666.git.zihanx@nebusec.ai/
changes in v4:
  - Keep post-CREATE cleanup for parser failures and document the existing
    best-effort close behavior.
  - v3 Link: https://lore.kernel.org/all/cover.1788516372.git.zihanx@nebusec.ai/
changes in v3:
  - Split the POSIX handler check into a separate patch and corrected the
    parser Fixes history.
  - v2 Link: https://lore.kernel.org/all/cover.1787486936.git.zihanx@nebusec.ai/
changes in v2:
  - Add cleanup after a create-context parsing failure.
  - v1 Link: https://lore.kernel.org/all/eb1bc35611f91bd10a4772400b37fac26f660956.1782579150.git.xizh2024@lzu.edu.cn/

---
 fs/smb/client/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 1b2ca3b2c2f87..12973f2e26b16 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3414,6 +3414,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access,
-- 
2.43.0

