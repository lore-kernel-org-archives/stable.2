Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671379;
	b=SGKXPv+V0E6Sq00V4qMWkJhvr45A6sAb79eMtOE1P/2z5ukqNviC/KkXiA4OBwVPnmZC
	 hiKheHb3uXxuovigYYVGM8vBkWQlBXUXr+yZLTSmnj3F/ZGP/Ts9cY+XVpuYfwPsXrRxO
	 aTj+FYuiB1SedCXKuhTIyX/rA8TOvtyGvekkgA1u0LhhAsyi7d6M6flHBf3q584s2raLu
	 K3TPbQGYxg86Izmxyzx0SFZF6H/Se9nXhD9YkqL1cVGmDraBLdWTRiT26DeKNr31/HbCY
	 uC8z11zM/1oC2xdy26t+N94VFuYDhfzQQuWRKDLmg/aK15T8taioMsobk0oVGLN3wEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
	b=xd6kF8J+hV7KYZd1Bsp3C7hq2OOw1ccxs+E2DHkXXZqKclejEv1esaEq4Bnap8F8pNCy
	 ap0Htwwf/lByyJlukcdZsrqgpwjNKVvr70jvvvo8UIkE0/H/+cL7u/E3CgTJO5qXOZ6sE
	 AMoI5R2/td2S1JD5AujlQJGpAbaIDAnl8+FGllTKrAZGGba1zYaO5yzsvYKI0c69NufU/
	 dNQbme9OAi6m9DHtBAf1bOvphdStRXlPa73C0YvyOtuY9n2PHt2WrHQiBMOni86qJxK2d
	 Q6DYXvvfITN4weH1rvRO04EDuK6AK4k4hDQWLGtqxPhaCG1BwnneWuwCXXD6xwEb+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b="Tc/6I9Of";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98690606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98690606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tc/6I9Of
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so14359915e9.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671377; x=1793276177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
        b=Tc/6I9OffOf9w2LXboWwsWCTHaKzntYAwzcPu9ZHb2El9voyZ6Qsyf0fmk02pWVPlT
         rWBChZJkR3gbwIBQhYRFyrmEVKoX9FBmGpM/IU8V2hn0ylzhnM086q08+BgN+0+hggkv
         XvXUsi4xnKrjim9LSwL7ZxUizBnsB21VUpzZCxfeyx2MZldf56Sj7ZV2lYzDOik0M6om
         qW+0evrWu9XFiHQaRcqPhfyB6qkggXdLH3Ycovfh3miE7ad0B7OzeYk9FUhHleCXe3+z
         CmWHtQOR+VWyopeS7UJMRXWgo6PatEgtpp3PF25c1K+6z8Q3+iscdU+RJNk76/QP3ikC
         nTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671377; x=1793276177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNLGOZBo9M0aOiQpNACAMhNlgQd5Qz2fgrOB7kzhT60=;
        b=SqGsXyKst9oTxE7TrLhDplKSvbabZfOT/igQhZx3gQVgb7yUhgpe6rde7G1cJmiWYu
         pKeeIblbYonlPvFRJv0VFFvJT/6yZSrDvZzKDVPScBD+cw9B8HxC1aGmLE7HN8RYMiDx
         6z3beOz2kmnguQgSD/tDi8GA8YfCoz4VwaaKxjdL4Z9dUNLUuhEuGn82ruwVWMb4kFBc
         bn8TLpzJ8EiaytHw91d+HlwpDB+CzusAEuC5Jjp4DeFJ1FYWbNmZ3HzJ3/byOQ1gGnLM
         0oyH3laxpW2zC5wP7qmQMjy8yisWETkNX9iK+/wK0+92xr2fx/jHfv6+s1/CpCOKuUJK
         dtJg==
X-Forwarded-Encrypted: i=1; AKwUvByInCv5H3VQgol4PXOvSw51ulyRLSH7AKbFYPfdw7qL3QVGh00nxLsMn8m5ETANUGHpcEU+dfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlR8Vj4UznDNChyNC1JdQHFm/CzY+zqYOmUKbVgdJb0LPpGxvs
	m3EcCGKFbzBQuLcQ2QADFOP92K4L1b04uv8MfVNwtxjIMmGVruenFCoaNdEoRBeWMAdqT3VFiww
	/mlmwKp9BqNgvi0IPH2If4wNXMR1dXuY67SSn+GyYLlKPUCCRs4c=
X-Gm-Gg: AYBFou3ZfOuFYgqwc1DZeaBI0r6ws7EsWk9QhCrTo6W2CNSUTrLp7aa6veRR4PWe4kO
	HWGnO2HmWNcCRqElG703PzkR4j1lScsmlc0DmsLw8bg86SFvMFeEwVnsBoOddHZFe+rbS1CuCM4
	2EAGpwf5FggWp5rczVPilq4k7gBVuf59TgQCO0RFt5wmprSnAl1A3CsWerbLWQZmUNyXztE1sZr
	lOC3SiHGB8djAyTL/368lqQ+XyK+xqV6yRBSqruo1pO60g44xGa2sUFl91d1cWI/Fwy82hHi5u/
	jVfJKjlcA6oPdTZDv1WaigHHcQ9pdvqW04VHPxfO2beedxA6V5O5AdTSLVL/ZgT5oLrYnkZjLku
	4wFa9+VcNFzwg5p2EYhn1wDjQc9GdIrZrc9RIl9l51Ssp+UPfyvRjG7cSpVJazYmRATaXRWuwJi
	4uRiwJITsUvz2jDEEeOQdFh4Ko53xy383iL+83D3/8SLc0sSftFEiD8Jaifrc8+9RJ/cymspApG
	qCs1eqfCYeC/V7xZljwmTHo3qVGOF6g5xBpji6ecBsGf7UZqWFrfUuIkvZ6o4xlxZE=
X-Received: by 2002:a05:600c:e557:10b0:4a1:6991:36d7 with SMTP id 5b1f17b1804b1-4a1fdd20ca2mr62839025e9.10.1792671376937;
        Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 7/7] selftests: ovpn: avoid calling freeaddrinfo() on NULL
Date: Thu, 22 Oct 2026 14:15:50 +0200
Message-ID: <20261022121606.732029-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

ovpn_parse_remote() always calls freeaddrinfo() on its exit path, but
result is NULL when no vpnip was passed (with or without a remote host).

POSIX does not allow passing NULL to freeaddrinfo(). glibc tolerates
it, while musl dereferences the pointer and ovpn-cli segfaults.

Only free result when getaddrinfo() actually returned a list.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 3b612a8a18fe..ce9436f92b43 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1849,7 +1849,8 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 
 	ret = 0;
 out:
-	freeaddrinfo(result);
+	if (result)
+		freeaddrinfo(result);
 	return ret;
 }
 
