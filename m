Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27348F832
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106525; cv=none; b=S/m9vT20e+4b46KPqgpPUjd109Xu01WdZyRluE+s//39r/XQ9V3Nt/UUCYB+xgjfxy1qKKJ0PLOMKXdT76LEUlnFDLF3tUlN8lRkQTQVtgkRYas0mkKGxrqegBYWg40uXF1DReQu62dMcXd1fyvqwK0oKs242eRg4oD4qXLoHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106525; c=relaxed/simple;
	bh=jNQfUoCT0rQsQDqvqd6O5D53mFke1F/vMOIqT2BbWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQ04BcFL0rIQEx7VbV7/Cg7/Ex8KXJDU6SYvdVhYyL4Br2I4aXp9cs2QdOZDAWBgWnokx6J5ReVGO0c5oYqz+lpUYynpIjoQNtll7QhAVZOGijUofo/f+FxBXZJPkCTvpgfMe3fHjL+5GladmNJX7JZLfuRqUJnz89mJ6DIC3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Yngs6Ziz; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Yngs6Ziz"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1437b77c274so114736c88.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106523; x=1790711323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=Yngs6ZizRnQJ5nZ5bb0PlLrS3snBDbovhsGFJgyhYEp3pH65dBRml6eAK4LSCTeYBH
         aEuTZ6McHQ7eYqBr1JwnwFMiF35pEplkxZWbwGnSDEFQVoWR6XU3ieGkHdmwqznMPSbq
         h7tq43GDr6LTW1NcX++FqUJTIt0hdDFULxMXtaEyO7FHY2CHxssjGBcj1QoUyxEGEpp5
         7QmehbZrNLsUQMw1uarITOVPEhNh+CZMx403T+vBlnOZUqTB2bg/t7UyWf2sdadbfNku
         dIA6Kc4lnZ3O5Bf934KCJoiggGhTxsWt0s/VgL+Gsfn5PFre0gXeEDSk5ZEYUPTIny2z
         LDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106523; x=1790711323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=cKqCiHjoUiE/iRQhOL9dSl0FRNqwiq9lsjks9SsX/IX3/RJh9CkYVQsz8JgeyMw7EU
         d7ink/CPIUnGSltz5S20r6m0BqK9PYOd9WqjsLHJeddR2OTsj9cntLHFX3o2JMNiXp+9
         3m+pn84ESZpzEwnCInERoZzClk59A75CZaQQNpaKh2bQi4ZnUv5YZevTgHmQ6Sq2yhcG
         crstFu5JtXAiNHWlUNj+yz0BiUYqicVLei/sQ685AzvQym75QyQB8rXpcHgGrre0oc5f
         hBbDoimlemD96dwiNOYLlxltAZQpjWh4OxKSanaMcKOxxuamMx+JDJ037uZhIDqrVMZu
         iMbA==
X-Gm-Message-State: AFuF++kXc0GouTWCow8aEh6DNyTbFbQtv5/KZqUTVwZeiC8LH+nd0q3j
	rVHAbdLaLHU6ibhVUlZtltpv08SVxzeLT68woZWaxv4OKlYJiRC9nxww6swXD2TE2AATqMYDGJw
	BbZ6tLNQ=
X-Gm-Gg: AYBFou3AHTDFHyngyLT2Gd+pFex8XjIFeIaLrxlq5cayZnNic7mIS+9WFj5K+5DJGYD
	Qqqv5ZIw0UaqUcyAjzVd6IazSW7vOECY36bsvu5Y65nPY865qER3QVmGCh9GHBSOovI+XLLniWg
	R3VXKL7UZMhURvD96QTC2M5GKAjuMu2Y9ALeawfnKxb1+x8bVFsWPXng/+W+hEd8S0qj0zmAEGl
	wZMcP+gRCMsE6dxoZHpLiatTl+oizawqO7d0EO8RD+0kaRtCuQXgtY281zK2KG2jREF/tP3PtZX
	hoh4StNiQOYG3L1AowKHEa6d+o2xHW7KmVtrSz9YqT9oDCG+to/aSHn+3oR9QGzcFHCvVMyE/14
	Ok/Ld5TCgbRFYj06piwvwEuLcdcwZqLByUEimoCN2SxKVowiTY89hH47GXA54wl6BdQOa0JQyXr
	khRjrfJlqlV6Lx0ONj/u1+bznJW/ZivGD5EOn2y012f9Jj0xa8otRlQDQhQwkFXNgLZks0dX5pO
	lNQ46ukzCWrNCHaAzyZBAKpd/wUdCIUE/o8x2lCqSHpdt5HyO6NXHgBX2e5Ou8Prh7m0jc=
X-Received: by 2002:a05:7023:a5b:20b0:143:2973:3cfe with SMTP id a92af1059eb24-144f91cb630mr410014c88.31.1790106522287;
        Tue, 22 Sep 2026 12:48:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm708550c88.13.2026.09.22.12.48.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:48:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6.1.y 0/2] Bluetooth: backport CVE-2023-53762 to 6.1.y
Date: Tue, 22 Sep 2026 15:48:32 -0400
Message-ID: <20260922194838.26223-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and Bluetooth maintainers,

I am backporting CVEss still missing from 6.1.y.
This pair handles CVE-2023-53762 in disconnect-all cleanup. The
second patch is the immediate upstream liveness follow-up to the UAF fix,
so I kept the two together.

Both changes are already inherited by v6.6 and every later mainline
release.

Could you please queue the pair for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Luiz Augusto von Dentz (1):
  Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

Pauli Virtanen (1):
  Bluetooth: hci_sync: always check if connection is alive before
    deleting

 net/bluetooth/hci_sync.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

-- 
2.39.5

