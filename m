Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2D3911A8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514097; cv=none; b=O+7gGG0G2AXte/k2MuxMI2tmmFhUsQ0uN9A0I6D1YV5BeEVYrYRt2/vkOI0RfFetLQWDcU0x1DZdQjONogTeODMJy2vdeJfG6Ffqt3XSFJ91tB5UnJoUxmSUumFSl2pXOkN5pFFeTKffYCl3SfdrrMG78+9As6LBzFeTYcw/6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514097; c=relaxed/simple;
	bh=EmyiOP6XPU9hCNhNZcQqvM05fyAVZEM4igPZJnzfA/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8kO3esul401KvTYC16yovJUzV2wKfocNuBb82JgJo7QBOQCbyHN3Pr68kQHysJAiGBZLeATXTxbhCPmee8xTH8vcExs2QF8ISthBwzsWRxrz5qzqA6zfw5b2Vs+US6Z9UqoHvUd1oUCH1IGHNxx+dW9b9/kR0Pur05NHI5Zfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so2415035e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514094; x=1789118894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SM8f5UmSN3Nb5n/niWiO3g3/GWzy/AsaKxBGdLsIvs=;
        b=U11bW4hN8OCjoqR9zTR19BeIDEJltgJyaAko4zVYpt2l9L7o3kc5A0dB+yO5dVB6Ub
         SduvFe4Eos6Bz5PSMM0fdA+cJTp6aVt7dcDOIsmGJiF0RrrLO5ldwa6QUt/TAtxO2HhD
         1UqE1MlYcN9/fdPEOTiE+BsPw9gjWCK9ByGKrbaxEZsVkk1LCgNnCGr3b9DymeUq3MlE
         lHrQJTXGR++Pp/lvtTJDtFRHFIMdbIGgCSiZwsgJzOwkbrn9QtoxuDP0rUQSAqw9+kmJ
         RYXwILPjDm3327YNyLJsm7s10Omqwh3J2ETHMIYM2CR7DYClWW4pslUvkkPfCHqE++fH
         w+aA==
X-Gm-Message-State: AFuF++n3ucnIQJqvDTMFD26w1iskpTW1S7pw9RZeVpGQFxt70Nz9h+/d
	Kv8IbXQRtUBp0iVZ3yjGQWCOfCws4nqXEAeoeqKfrpasP1+dVA2TPWfz7KGWlj09
X-Gm-Gg: AYBFou3PZgloPh+ls8Yk5qrKtlK792FSQMtUtJ9tOE6n26/oxJAIsmSODe6KdmtcSja
	JzkqwLyLZqlEbMZ9fcXiqOrOv4P+IfsyRXDTeiZeLA7C/3f67ky7yiPzKMmzCldEGYczrHoz1eb
	uC6ovhTBaHqNO8xjS4GkZxlmimWSdJEahk/5VVILGl/6xxzsB04ubvx99raDeHl/VOyLhSgSD77
	d94nN2a3Osi+/lw4+LD3FLGc9oZIjr2eIkpQZ82kiCROXYFku7dBLb4wno+/7s6m8+z34m1GkVd
	410m3xqJInFQn/5co8xp/phbIZjhc7KAa9O7aMveWWhPQwCyiVu6YDTeu99sAPw+DLPqKy4jZrN
	6rcpvjPNj0PYCfsiU7hnnVHjFIU1//FTtf35T7a9bhNexIoauwwKLaSfytu2/FIDKyA1LoY17pO
	4baKPnVtLhLGT0XTVeVImkjzE4Wct5bO3AJ3pJVykUw1qWp2JHmmuj7udDGG+Hh1jD318DzcqOW
	Ep83qK+cTAsCt+gqEK32rDoWJfQSg==
X-Received: by 2002:a05:600c:1548:b0:49c:fc6e:a3d4 with SMTP id 5b1f17b1804b1-49cfc6ea70fmr19349885e9.19.1788514094232;
        Fri, 04 Sep 2026 02:28:14 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm5108934f8f.27.2026.09.04.02.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:28:13 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 6.12.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri,  4 Sep 2026 11:27:45 +0200
Message-ID: <20260904092810.1813221-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090349-submitter-decorated-2272@gregkh>
References: <2026090349-submitter-decorated-2272@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch doesn't apply well without the previous kernel-doc fix.
It seems cleaner to backport both instead of modifying the main patch.

Ilya Maximets (1):
  net: openvswitch: fix kernel-doc warnings in internal headers

Yuqi Xu (1):
  openvswitch: Fix CT limit teardown use-after-free

 net/openvswitch/conntrack.c | 121 +++++++++++++++++++++++-------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |  26 +++++---
 net/openvswitch/vport.h     |   9 +++
 5 files changed, 120 insertions(+), 52 deletions(-)

-- 
2.55.0

