Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986826;
	b=y7JRZPK9qaCpvZ1bqFmKSYI6CdEiObHcosDsEP2g33uozfYAhIDKQ0ZNngzMSJmgNeJI
	 Ek8+tVJo+Ga2G4hglHZPbzNz35OW8XGiI0Fe+K+zlv1fqxpD8cIqVAgptFdENQnL+ErSt
	 JXb2cj52zdY152w+a/olZb/y891k3QjijRzSKKZxtiPtmYQS6f/oPZICDpWhcNK/ldCD7
	 jeiYDbuLF3kT+u4fRhGMO38UrZ7uk47dEdrxfnUl+MQWjpsKdjgJSWOwtIW1uGa03+X/K
	 4eH65XmEd+4C6jGg1q4zt4oLsl4IEZzKHh0E5TExS2Bu/HLMY2JyssCWfB31+lLm76A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zANzWoKvBu6ISmxHtAdZixMys03+K9+RePovcEEC1NY=;
	b=a4rAu9K4+J1m/oAmCkJEfAqUb+rH5ZhrC/C7dZbOOjfz6bjkUKsKppTKXtGeU9Z+di57
	 hlsOJnvAVOs7QHL4MxeTe5Vzi594dyKpxx5AvxeWwi7WN1ouSRpfCW2YvZZHN4ZDmbdMJ
	 +TFAFZK7GXESDR2p6hwRHhZdRy2+L9vjTtehdR34vnM/gH9mDp7mwLggOP3Sp0mL6brPY
	 O2vwHgAeMrg+KTAPZ75VfqdNbfOg7TP+EDl2FZFGscf6awgyfE1BkR7RZJ+8oU4lqgZu2
	 5zkFVJNW8rkM24HtJxHgZ7J8WSrEKe950WqG227ZLsSI6f04SZVEZLvVAlfis8yD1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=FWokIqS1;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431C606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B431C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=FWokIqS1
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso460765f8f.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794986824; x=1795591624; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zANzWoKvBu6ISmxHtAdZixMys03+K9+RePovcEEC1NY=;
        b=FWokIqS1NX0v4mhawZqL/V6H71jWUSHvjb/OUUSIgQjv8hO/W1zwaZ6YoisemSaIlR
         EsBHl7tt2axR24UU9pWMlO7OrLDkCM6yR2Z1XialepdfD/wXkOLwHfVa3Kqn0TuAb9OU
         Y/rfLcbMaGwEubC95+ywJVcf/lclIFNZbqiMeW1PZPU2RUgPt49Dcqo7auvvyDLL3JXU
         vdjq+c5yw9QcjeInFaiQVKuRjWto0F7Z5ZnUml7I739tTGn00yuqsCl8JnzUBY2R18uQ
         kpVU5bVoNE2yR+MRFVkH1dbb349eoWFww91a+svAfsZUYuXNKSuGE6XlpI8YgRuaWhI8
         8fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986824; x=1795591624;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zANzWoKvBu6ISmxHtAdZixMys03+K9+RePovcEEC1NY=;
        b=fYKshWnexV1vI8iBhE4WFsaDEqW4HWjq21z+qX2++UB9CuyXVZu6ITISRgwj8kvUMV
         EooJw3jGg75ea0sEbdt86KPLEq/b6bAblclvE/bUh8wYMuHQZ0xWk4BFN+GSPb99MqPQ
         gfRnA0t5nJUjmGxiv/Wk0cl2ZXILX0K5ubVGm3ywigPhhcy0d7fP5as0WAmJ1V3tq4Oy
         A5J1Oj7/T/YfFiN1mvOFIhuCduVUbHJAJfiFDSYM+72nvNQ5d20fvjFo0IP0VxzULpgv
         vmOyhMMagnZEDOO1brTNMjK5CmPFcxoPxzEZde3AqY1OrkM/jnTZId4nNFAZKeCfeZnS
         OXKg==
X-Forwarded-Encrypted: i=1; AL+hErEVupHquPSgO96muagQF2EN/Qi/iAPxK/TLBhyvi6/bF4caJQXlzUojl9RHB33FW0evof7W5rY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YYssLk0mfxEEsIMTDQ25CXvX46nyvWUI7PTwOncvrwBZ3pKEC
	SlFjCneqf3GHFwi0CppCNlv5vCbK4gESHvUplDeLca4/7yJu5Y7EJ6cIzT33IyLd1nk=
X-Gm-Gg: AZFdTZfIX8UBqHTT21S0r5q3P3pYJd+PUrU4ALo12ib3PcpQvFkpx13+CHXFT06yD5p
	pGwfOPpTCGqbWWGt4LkpFTs3SDP8SxspWJ5phQw54cNTxZxPathyi4m2qJjHzYuGb9DmdMCGqLb
	DeD+cvBIdF/TqlmjYJebby5C8/hmqlEI600C+SphfVEsSpk0vWnRxWzkLNtjhgVuP1LdvODSEQK
	WeUfgPmGT8CmUBuUVpotFup3i/IM9CccAW8Aum1PNHvPLpMod7ta7lAHZI4jqXTtDyTRHrPjU21
	nL4mjxYufqFHeHFJLF2Uz70IzU5UN2iA8zD4d0UXIz4X+GF1ch6Os2/u4hCQ3G9u5W5p2z9TNIs
	g+Owfn3e+BfJWLKd+pqjotvJ5Xlsyt4PwL5rnPSrXp5g2Hvgt6y3yLPp4X6DDF4yJOz6QpC+H+k
	jh8/lU2IpE1lghjujuW6BcP6DV4AN32hCOzC1+BUw8r7Dy8w4RBXrMu2qVQkB4n927NCW3whVlw
	QZUSsL2okUXMKAVeHcmYP273SWe8DikI6CvF9r/rZao/tI5G8d/KJpvPseDP/D/7MinvzQdg7+6
	TApwiqJWaACQVJJs+41CwO2xgpjHrh4Gaye3DxoifH9uJuEiqm6LKmfmDjlUc81RaGCDbP9Iee+
	heiHUvcn3fIE=
X-Received: by 2002:a05:6000:184b:b0:48c:4658:602b with SMTP id ffacd0b85a97d-4a637f6366emr4060212f8f.10.1794986823892;
        Tue, 17 Nov 2026 23:27:03 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095f21sm2901099f8f.38.2026.11.17.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:27:03 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/4] usb: typec: tcpm: Fixes for talking to the cable
 plug as a VCONN source
Date: Wed, 18 Nov 2026 11:26:38 +0400
Message-Id: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PwW7DIBBEf8XiXCrAi8E59T+qHADv1lSNTYBYr
 aL8e3HcY0+7I83um7mzgjliYafuzjJuscR1aUK9dCzMbvlAHqemmRJqkFIAryFdeFmp8owFa1s
 THwcPTuqBrOpZu0wZKX4/v76fD11u/hND3V/tjjmWuuafJ3aTu++PIM2/hE1ywYNBqaG3ygbxR
 l8xJcyvC1Z2fhyQjNdba1APMkuuhrnlb3XQASg/2IkQ0ULoLZJXxsA4KQIB1rRJtEfzriAP6+U
 S66lrBgcT9kaAGGGAQFYLiUF7BVpOBDpYQA8twuMX9UG9CUwBAAA=
X-Change-ID: 20261104-tcpm-soft-reset-sop-96b4a156f823
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477; i=alchark@flipper.net;
 h=from:subject:message-id; bh=8bckKev/hAlqltCilTB95y0D6OerJ3QVe/I4nyWcAsY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9DTZ5LGrB88J16U4X66uSPHM+dvDEz4ryu5l98Rzry
 +iPG5JXdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVj+QZGTreTTx3exsv+13VaeINc7r/mZ9P3r4z4k78orAuyVwZ4yuMDA3aTHc
 yq5eJzr36Nm5dY6X8sS6F2IUsKZ0bb2f2c2gwsgEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

When a TCPM port is the VCONN source, its exchanges with the cable plug
on SOP' can leave state behind that later affects the port partner.

Patch 1 fixes a Soft_Reset meant for the port partner being sent to the
cable plug after any SOP' VDM, which left a source without a contract
until unplugged. It needs "usb: typec: tcpm: Stop a source from
repeating a cable Soft_Reset" [1] first: without it, the repeated
Soft_Reset after a VCONN Swap would now go to the port partner.

Patches 2 and 3 fix SRC_VDM_IDENTITY_REQUEST, which replays
Source_Capabilities after the first contract, and stalls until a Hard
Reset if the cable plug NAKs, answers BUSY or never answers.

Patch 4 is hardening rather than a fix for any known device: it keeps
messages from a cable plug that breaks the rules from reaching the port
partner's handlers.

The first three carry Fixes: tags and are meant for stable.

Tested on two FUSB302B ports (RK3576), source to sink through an
e-marked cable, plus injected cable plug answers (ACK, NAK, BUSY,
Not_Supported, none) and stray SOP' messages.

[1] https://lore.kernel.org/r/20261103-husb311-cable-comm-v1-1-6217dabc1a85@flipper.net

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Split the SRC_VDM_IDENTITY_REQUEST fix in two: keep upcoming_state for
  a message from the sink and clear it when leaving directly, then move
  on after a NAK, BUSY or no answer as USB PD r3.3 9.2.26.2.5.1 has it,
  keeping the timeout only as a fallback (Sashiko)
- Stop passing Reject from the cable plug, and pass its VDMs only as the
  answer to an outstanding SOP' request (Sashiko)
- Link to v1: https://patch.msgid.link/20261117-tcpm-soft-reset-sop-v1-0-c7e1543828c0@flipper.net

---
Alexey Charkov (4):
      usb: typec: tcpm: Keep the Soft_Reset target apart from the VDM one
      usb: typec: tcpm: Stop replaying Source_Capabilities after cable discovery
      usb: typec: tcpm: Leave SRC_VDM_IDENTITY_REQUEST whatever the cable answers
      usb: typec: tcpm: Keep cable plug messages away from the port partner

 drivers/usb/typec/tcpm/tcpm.c | 131 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 14 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261104-tcpm-soft-reset-sop-96b4a156f823
prerequisite-patch-id: 2ea442b68dfeee84c38efb27749d2f40487d2fff

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

