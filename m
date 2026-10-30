Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353608;
	b=p0Sw4VTWhdcTJLRZ/jal85Mp8neHPNCO2KGNwQWwprmQHO9Ok5HkyfyJ5ePvMMu2I6a4
	 /nTnFDQv/+XmklLx4EQc7w8QGakNxSVzNUBeT0KALggLIvNJlkwrQDuaij3Ta3vq0JrFZ
	 C1ad1CGaiNN5xRp/tQUlCxVBYotPiVil6ZoJACDBjBRUYSTuSe2Daj0W+FzrnpeDR7eaC
	 kExPHQQltwjF/PQB3B8EDal/KO5JzQLbsPm/SAjvpld9TUiWlAmWKtJWQRMbM89dJ60pk
	 kkAKfU0gYGtIlGoTG27o2rH0dBPtub+3wYPzYMgvi9kyt5VUehkzu3QvZas6yrL3ICg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
	b=pun4N17oM+3hVqMD4jngzg76BAHPTy0hvyPWYnggMhlDSSKNTAX++SjuIfHq2LcY9JzK
	 xx95ast9bXKDwG4XxXJ0DWK3IKji2zdRKW2JtXBIFupt5KnK2n178heJMLa10f3k87Tki
	 88DzVGER+B1eSiysRmy+KJ0BGVs3wfVhHMcng03VtQwB9e/ryWVP9jhgFc/qdc9USyMzI
	 8WgRS10sHyQN3oPW0/5f/mlqu0MQkyCK6aGcy/by58koeG+XluULsdVRN6kkRmIvnaQFx
	 XLjS3urKJBQa00L0NGyqacMNnBKQQdAKV90YZhvE1YOxGft65105fYRcwgUVNP3THmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9864606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9864606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso2873535ad.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353602; x=1793958402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=0kQNarSxZeE3Cgu1GV71IQdek42/dUZi3/owzf5Vhn4qSxRd1DyUIgfdlVEZ4HBb/C
         VYM32ZLAbj4dljoJS/GPhetwNEkkYloNNXA9XdW28TQUKhX4pJl2aOPcutJ2jPZWxPZJ
         mA6uT/BkIi0JbMbAHv7iJAMvQWG2CgRcaYFqne5jC4z/7mQcojmPslt2/MvEyFG43Sgv
         uWg7TF056NBGJI33kAGa0OSnk5APUaPUzs5z0ECZD5fukdrTttMeZCjrH5IQ1zNCrBjj
         B4R1XvC2/XOhfJiEEGil+7LysefNDT2yzXI9kEBdXd4K2FOw+x+AqPbqaPAPhvfMbWNl
         bN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353602; x=1793958402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=j45pbES1sHE2k8qb32WYamQu7WEvkHEbLNtv6l2CeeoBA9pmNvNroevIFvnyHAPDzs
         PpaD37TSeCuQg8PzWfhIT21Bwf9WNHkHxRzfQQMYWylDjPK6vvPrJF7pav9/AYca3+fl
         O1JLApudMSKQNXT4AoYVkhAXzEuNUd0SAFXkMnKlVuZ4X0DXSE+JippKLKHolB4lunKH
         siLYt83w5AgqjYG80nt4rSySWtQr2krs7QG3BuzaEro394mMFn1QwKrJFWHJ9mqSykET
         ApferFSBaSgPxfuFKzt6I3803CtAfOa6G+43x+BKNijBhHfBHlNTEn2zhgpHMDp3FBdT
         PnhA==
X-Forwarded-Encrypted: i=1; AKwUvBwePt4ESiy/SJ/5PcDctj8Xyep/oqpO/DXMEbtIjY/ogDpZE/ExOSRbYJ9nmj0B4YdmRqg0Fhw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGvR1W7sHh6Myg0MZOxW8eBuX2LbAkJNhigGR0IF1MC3FHjind
	YoCKm6Gjw9vo1ff+25tNC0XIfE2t1o6JkuBJ9T8PST2LKV69w6fiMYgD
X-Gm-Gg: AYBFou07jxsvZdghJFy+cOS7IGwsNr07gRkDDT9I+8nh2M8pl+evGtR1bXtqpREsHPe
	0p/VEzKGUCXU5LDU3diu5loq/Bpy8NsDeN8YZKvdFNrP3CDdIYaWmyCFZSgbRQ/PWTyrfwV2Och
	0elXvLVl6uwEqhv5urQCTKoH3JA5JF3eC3KOQG1XkPucWQiIbeZzg6OnOzVIzjtEd+ddW22UocY
	QptPDvpyCbdRhMfwp9LVZFSyWQYa1IP9O1m39O94Ql4LAksw/aT32R7TxY7/WQG+WrTe+saa+ps
	eo/Jph4zAj9OFPegrdFwjp9bApf/B0Sy1tKaIwIcU3Xy0DUGJkO8IbyXbKsiQI5O0KqsjPsxSfR
	8GpnQ6aXEWFT6TolUVvjCe8rtEvFKAJRCh45heoXlIB4DNOuhj8CNpAG/5excneIkokT39I6RIB
	mxgoI3bgnLlTaQVhTT9nNa7mqB9CkZKDrckYqgrHBQTq/XvlnzVqkfm0TitJfqKj2HX72HCHrtr
	caFt8A74o75GSFLpgb1u4Jo/3c1qhtv5IlP7piGc1G4wrCCUV/Uc2ceG5Hrmm+ygKJK75LKAGJS
	Z53sB2m31ej+7g7r71Z5Qzd31K98uFJIjQ26Xt4m6RNpBq4f0dDi2orqWjYm6bg=
X-Received: by 2002:a17:902:ef03:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2eb3649be5bmr20449825ad.18.1793353602042;
        Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:68c5:29e3:ffaa:7181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392aa7bcsm4998055ad.67.2026.10.30.02.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 02:46:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 17:46:33 +0800
Message-Id: <20261030094633.27910-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Makes sense, thanks. I'll wait for their feedback on the selftest patch
before sending v5, and fold it in together with the rest.

Thanks,
Rongzheng
