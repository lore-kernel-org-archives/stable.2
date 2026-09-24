Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E34028C3
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230969; cv=none; b=puZtRMyrxSivI3gT1tp9OL/2chi1gAQjiDVF9/b/JZPDE5Nn/DV2VnhYAig9gmG0eUdvENbK/FtL2mZj48F5n+CpDNRNrIAPGkvvad92fQFuahUkJ6CkzRcjvn0sjFxUNAaQPNity/tAYGlIsJMFK2XTo5XTSdznlNvVmCWty18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230969; c=relaxed/simple;
	bh=PA4WHdZL97fHMVeMYVBzQqDhDDVdPEHyHKSQZGzkDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQfHVVHSxQFc8MGL3GL9JZN+OacNYXxWUx+Fk6GqQewe+CNOVTPG390OWO5cGYFLtwt+v0IsQYJNUx1WIkxX0/SOIb0uf2Won2TRx4plVMZalu6JDh8YAHWEyiYL4RRH0C56WvkxBI++7+LfIVxW8CdFhnzAQ12teJJu/wFYDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/lMUaCK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/lMUaCK"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so9962655ad.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230966; x=1790835766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=J/lMUaCKLRVqgLTwn7tCWfXPKoVqIwXhjTL3NImowkZ9JhHlyw844ac6RfSfh8HLP3
         Mt3bOrZ6uZEgDpqBAMpRRoT+GwSGddOCg8wXBPWG+9ln47Ir3XPceFK9iWgYnI4sM/3O
         +H2jKuKGMxhzWUh8P7SF++ZPFFWYP9RUuqbxITCIZQ5W/5EzGGToADbwY+66YHqeB4Ab
         EfnVWHqQ1K1Ps+zYx9wxfdq9VJZYHnJDgvqJ04ehiz0g8FBUUoaBoP3AnH6AaWsBzRuH
         18Pomi4cSznbemu1YMdknR3ycJz1RXxlDggZ1KziOjFiNyDo10DQepCerIFOAYF0q4sq
         hmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230966; x=1790835766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=hC+tc3ORa84h4mRgLSGUhLTByqNebp9q0RWYesAlyp2NMxlOeAJlrDHoTDoLxaPcZ0
         i8Dz+GFZknbmy8hZ4WdxlpGTZuPeBFtn/rt7BcBnelcoFjW+TIvJn8AzC3YfQxZdrctc
         k1k8q+5DhHH36XyFMqUFuU2zRCYbb1VwtgnXPDBBdjSx7UwEid3ptxtxUrqG0jTWI3oi
         kyS4vL6Y6xfua6GaoYUfH6361BHoXBEPuyQ1LIpY49WJ9oVee6ui4gS1GItvK8+lE4eX
         SpaWAU7BECgIc+WhWe4RxGgmuRa2+RtlE2eFXkMZMpgEjiC0lDWkQx6hjbpG+XlxQ8Rw
         uvoA==
X-Forwarded-Encrypted: i=1; AKwUvByUOLtWP3jsGH7+erCmA+2aEHvma8/kR6xeZI+dw5AWVuy8CScHHi+g5i+eOh+1XmTHKqKHudM=@vger.kernel.org
X-Gm-Message-State: AFuF++lFEZLsbZeIw5zZL8sr1GxSkoMq6cvElpB0pVz9ikZ+7luzsiiP
	FeuNtsWMRpB4gam0ElexgHUhu+qDfWWtznqaTQ6LAp8c+LPPY8LakRv+
X-Gm-Gg: AYBFou0m8eUfWWKvjYUuJH1gOmggAl6ZmO9dKJB1lamNDpe54MDiTDc0uv/B+AozPiX
	qY0vx+yp2RSKYIWFhJWWPLwuquW3sN+KrWBWzxZcI68UlZDpQtx3pLVq364ljOsRrcyzmVgD7nd
	78ZofqkbPF9j3okuIXsX4WOVfk9xS+qkDy6RMJeGZ8HjWcE8H3FWEpr5ZILNJZReepvGjUwM8yz
	bJSY8gqGLbWuwPJm3tRFiumpt8fy3RpnITTF/qgl05oFo8YnGHrCGa7QmH0OBFyO4T/wrnB0IFy
	+flOc/pOI6l9XFiz2bem9RHEJrbtW3ZStxLPaYfsJiL4Cd3IQsHh3T/8zII73RGIqNa/QGtfZeC
	nNYPnSZjTqyCbIs3r2a8SnVMEk16+h8EcP4x+fzFHYS6bFCzajX9zbHdICtYilAAHGHmfbnfxvr
	3r117Dj9LnSW3zT9ohKEU1L+yUfjat9yUMqP8JPJG73Dup7HuZcXoxjPRwR7omjQGyHtydoSMfc
	evx6q8cAiVm35OZOssv0jsXSzqvQtOpGvnMUYLhL6TxXL4cmc+ZglMd+P4HfEJWtA601uvdrtfh
	fYL9lk/0qQ==
X-Received: by 2002:a17:902:fc48:b0:2d9:484:861d with SMTP id d9443c01a7336-2df7e24f14cmr11867725ad.10.1790230966408;
        Wed, 23 Sep 2026 23:22:46 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm21220615ad.48.2026.09.23.23.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:22:45 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: h.morris@cascoda.com,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: david.laight.linux@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 0/3] ieee802154: ca8210: fix stack and slab out-of-bounds accesses
Date: Thu, 24 Sep 2026 06:22:41 +0000
Message-ID: <20260924062244.2444225-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three out-of-bounds access bugs in the Cascoda CA8210
IEEE 802.15.4 driver:

1. Reject received SPI packets with len > sizeof(struct mac_message) in
   ca8210_rx_done() instead of checking len > CA8210_SPI_BUF_SIZE (256),
   preventing a stack buffer overflow when copying a synchronous response
   into priv->sync_command_response (a struct mac_message on the caller's
   stack) and matching the actual SPI transfer length
   (cas_ctl->transfer.len = sizeof(struct mac_message)).
2. Initialize lenvar = 1 in ca8210_get_ed() and validate
   hw_attribute_length against *hw_attribute_length in
   hwme_get_request_sync() before memcpy() to prevent overflowing the
   caller's stack buffer.
3. Validate the received SPI frame length len upfront at the start of
   ca8210_skb_rx() before reading data_ind or allocating the skb.

Changes in v3:
- Patch 1/3: Check len > sizeof(struct mac_message) in ca8210_rx_done()
  where dev_crit() logs "Received packet len (%u) erroneously long" and
  drops the packet, instead of silently truncating the memcpy() with
  min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3) and
  addressed Miquel Raynal's review comments on patches 2/3 and 3/3.

Hui Peng (3):
  ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
  ieee802154: ca8210: prevent stack buffer overflow in
    hwme_get_request_sync()
  ieee802154: ca8210: validate data_ind length upfront in
    ca8210_skb_rx()

 drivers/net/ieee802154/ca8210.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.49.0
