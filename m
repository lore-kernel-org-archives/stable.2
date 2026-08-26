Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D348CD64
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781914; cv=none; b=bqgtbldGOXyDGQJYWBV2LiqnCDSdfBcZeUbkog5aUK3ldFFgA2m17b3N/ku7hgvi33zKVbMNJYF6FLVPLTCz8y8QV2zgJPtmWe38bGf/GB8oxt+cZ2WPsQd9sWArgpbzjfu25jOSef+OLfCwFbhcJKLl1A+HIH5QqqVQlq4Rkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781914; c=relaxed/simple;
	bh=mUOu4prFbH3IaF5Zx3eYa4vcy/qKSL+mXorCQl1XPlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8DRYUGce6C71iW0qKif0NXEYGSkg1XW2d1G8fjm35Kdi32brydD8/Al+fgGlziocCs0Ad1PfStUhkeoguZn++Dwh4w1kg04D3Qux4GaNUnU3GDIBlMY6kgVnlY5sa/PVrsKUfWdmtbYV1cO83GFjz/UptAIvZtqql+oQhRjNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so165751f8f.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781899; x=1788386699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YabbSQ2ZCljuR5SzDy1HfG5T6nOzAXlSelOf65B5pQ4=;
        b=ZJfN/RPxJCOqm3HHCc+SfkcDV8msGaGzcTst9Xbr7FTKR+MemZy1aqUfps0zA120/g
         unEkm9lzILRF+laJiPC6b0bolxKI0edin+FxZk0PuBrqQVES6llZwXJxbQxuDnoMjdVz
         3L+X3XRLbW4rCREPN8Ch8MHNHzn79zvGsGY98O/dqkiDAHPnd4TXl6yPkw/IEZVlNriA
         5N0GgwPek2/bEhZ2EKys/xCUUPC4Zsi9Ar+6DMHdkLjS4FNCBAwGIhCbmpX924DrgQ8K
         MhuJCKtG35uK2THquWa2kh009aUQdTEyWEVEghHmUC0uuzRQkAoLv29eDYPOj6j+JTcT
         NUOw==
X-Forwarded-Encrypted: i=1; AHgh+RrIYWUXXvCskzN9Kcbfic7PHzxpIm+EPiQoFYgLaa7FoV7WsT/t76F4JYYKux1aIIchbb9ojUg=@vger.kernel.org
X-Gm-Message-State: AFuF++n12QJFvZYNespZjbwbBHFdFUOV8xzaRvZjEkuf5q8h7zu4Hpb+
	ttCRHJCZAWeUXA4cWi2CEbkYwZvqMykP2JDjAgpJkk254aPbaOmfXaIj
X-Gm-Gg: AR+sD11I70Tu7OGa3LB+zDO1pR0ieYYIPySmST3CCVcbLR7mDv9ko08JWyRJUomshRI
	ZZsc3ZP8tU1oOnyAM0mY/u5ABGoT0WyBpGmae7qbAv5GbjdrNYuDYAHhJbWpAojzwn0KBQLy5Hd
	dok7IFxE+9tL830yMi+KaNm2Ht7JJkanEdZbP4RDjL3HMd/TeOSo2vVocehKNgqLW5EOuLriths
	kHKKCDqe9/Kyz2QzCEBHVCb9UXXnsEGyeSaklvifCc7F9aLF+qLBLpgu0K5RLg3SDAE2shIwLzw
	40m0FNaqBP642SMoXGW8bO9yXhsLlPKbaKi7fwSGV/S7odCH+lxyEB3wFd23xhlmqgpS/p4Z1hs
	eTTgdQfqoKSztOnfMoCkau2k5A7f/oB+rC0NEtQFECvFPBle5BI9ZhEe3Wn2aXnUrEWyqjyAfQh
	UeQUnucKkF3yWIsJLVHbnj0lxsoeVq0joINJTUogYRxxqigFqiBKIloXKdOtv5ycXTx7tb2uunx
	/3FkKYm2/2WH3ZFYQ==
X-Received: by 2002:a05:6000:40e0:b0:482:ee81:f0ca with SMTP id ffacd0b85a97d-482ee81f321mr819706f8f.12.1787781898817;
        Wed, 26 Aug 2026 15:04:58 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27a9f0esm4446370f8f.10.2026.08.26.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:04:58 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] netlink: specs: add missing mask attributes for conntrack dump
Date: Thu, 27 Aug 2026 00:01:12 +0200
Message-ID: <20260826220444.4054714-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826220444.4054714-1-i.maximets@ovn.org>
References: <20260826220444.4054714-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'mark-mask' and 'status-mask' are defined and supported by the
conntrack dump, but missing from the list of arguments.

While at it, the order of the arguments should follow the order of
their definition in the enum ctattr_type.  That appears to be a common
convention for other spec files.

Fixes: 23fc9311a526 ("netlink: specs: add conntrack dump and stats dump support")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 Documentation/netlink/specs/conntrack.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index 6ba28cb1c2ab..b1eb102ab843 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -604,10 +604,12 @@ operations:
           attributes:
             - tuple-orig
             - tuple-reply
-            - mark
-            - filter
             - status
+            - mark
             - zone
+            - mark-mask
+            - filter
+            - status-mask
         reply:
           value: 0x100
           attributes:
-- 
2.55.0

