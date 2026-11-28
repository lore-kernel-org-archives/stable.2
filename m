Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874787;
	b=pgBjp+LQWwnAzYqeQuYM3txFt/dS76qsdz0pd16f6DJg5rKpk9KNNphl11IJuw/ClTgs
	 yQ1oWTSeENmkVuVVOJzZWt3N9m1cjOfrr+b1rSm2DN6d3KHdBXsj6n5O653nLo8Sm6Nh0
	 HD9orSe/RI59ohEW+NsX0MEpwL7dMXEmvYUHunk7gjSagIYwOa6fF1NfjQPDGpLTpyotT
	 Lt6xhOgaXX53nQfP30K0XX4hvgPPcQNgAXJAK1E29BvPTcjCcK3vYu8xvbuUfllifyQOY
	 KuUKixDzGiQAw+tSy09VCSMGZaUNZVjbAXcIVDSJJ/8tarX/ip2r973t5bSdEN5ip1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
	b=HiYbLvTFoEZGC+DuWzihBgYEf1Q40E2XdnaFOAvo8ZCAZicMsXaCkie3CsSDwozjthos
	 RVbZMJntajwUM16b2dPEJiKc29fXa+Qc7/8Gs5+x5dU2EB/9JEWiRWgZxhNkDjyoKKD/b
	 1tK9/bOz90qlDcfiy/AysBClq1GvmBcHfidKr8L4owHHet1IkEl/vhdnWRFSpnfLNab1Q
	 ZwEhezusdRJhaYEkLOraUiE0l2dF3vFnB/BP+5I01WmRvRxXQ3s3tQKUvrEwJHvfCIRTH
	 AgHg4lDA7clNjVTI1y6CNuk0gQGnp08Jk+N5pxBmImzr9bYaspRipBJoB5iG/RcouFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJTWve60;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B13606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 14:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJTWve60
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5495d549924so94066611cf.1
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874786; x=1796479586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
        b=PJTWve60gkjqokB9j9i26wjB02mdIzdtXwOjB6PqhfailjyAe7ApzPFiNVxkuKL8LM
         Xd3DlUZqP/CRIWTjXjIfZOR9lxYbyZ9U28ikqqoEOk49AIGBunNOaIMGw8pJkdA3UyYY
         /Mc8fLGHxGWQ6Db0Kv50pqepr4FqsFasBji5+4LeFgqxJpyAtK7OXyLeWPrdmrq5a4Ht
         2Iip9v8mvDbuHMq4M12V6lZ1otYb6YnXBdxsejz/y3VXMLWYST01SEWJP0HWIcGJT8pv
         KSHKmWY4PcFLAFUxpgthYnynHIh6mah6LZ4eJbaqsiTmg4L+ZrN8q6HZF0JaUh0B8MhO
         FLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874786; x=1796479586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v3H54DsDzOYnj3Smze3+HlsIoq0mUB1s2ye+/e1WTeE=;
        b=Gfok9/II7EwepTis1vhiljewW0iOj2SoWU7v91T3VkvFRvpzfEvRWi62BTpN0Q+hn+
         2YfEDjN9Lb22oso7nbNchyZRmWOhT7E23ced+8SKZPmjL3Xl3YWCNQPzwNGkC/K8P/9r
         S9CjuLJIHM8uYFi32GBXxjqlwhKal2oBDDrUuRySRBEORCf9t2+YqiasnWF9OXjQiG1L
         4jrTR1UU6dr/Oxf1ex/ayyRkuuSJU5GTfNcoa2JC11Ehi1LztTr70bD+5YjzvrzOWVLC
         5EUoNpBOlSWtbNhz/gY0FV8kdy7BHLLIBI12MGjYINYi0RGfmviDOf8ouDEyN5/d3eiq
         c5qQ==
X-Forwarded-Encrypted: i=1; AL+hErGvQXx6XDM6L01DPAtqpu36vvqWM6tWpnBFll7n2+tShqK+9nE8aPZfs2G77SumXZZkbCe1wXY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j3HvuHk5x7Gvo5bmYoqnng1phGPkcpx4XHqrO2r60dWagyuAg
	4PJ/yYn2leetMOmb+RgND0OA89yxjtzkLMVA8EHJtJafjHvZu7Gur0q+
X-Gm-Gg: AZFdTZeNEUZ9e+q2R3IMkssfIPBSBH9QW8ydfq1mWJBdOQR0NzqURf5bzYKi4dwkjKj
	DrJ7WowLjbdBPzBtprS8Ub3JXVX/+LehnaoW1Rjv+AiSzdW/fHxMMv/kKswXOt1s5VnVGHNuTjO
	vWSG9O3Xdbi96OE1QrFfQ6DsFNZ/M2MO/ivLNN6Cd0UcudojacsRkNn3ZyO5NUtf7imj2QQv4/4
	2AyUsVhDcPpIedqStkroafzJp7tEXCgtOzyh0WAUkPxl+yPz85II/9YwzzCjh1Phg0ZhQDeHWPa
	8BDbJeya6SHN5oBtr2gWhrJpJnrviF5/T7LlVekaoM5cPV7Lz0wCBHSkVdVeu7RYlOV6icy12dm
	3ge1nm6jqBvCr/8l3wWhtJ4FvBznIMW9xO6PavsUHF8nD5atku/Kem4uBjq7sXHF1odANivEQqx
	2dTIE67txct7LWwWTsIuf4HJYAQJ/2YXLwDBqk1cDEJmO+WRWNWpRRrS6bHBFSLdCBsVJlOJqhs
	1XbqBnzKgBixdCXA1N536UA6gzqDNbOfy6CqMKsbJq6mM28R3+xJlJFUpzXnhX3d4odwpnhUNIA
	sfURHKAutU7A5fXqzhO0haBcLWa8gdEF2qyG3y7HAfAMRJqrz01z7+M7vqdn4ZiXyOaR2VCQGut
	cWGQ/
X-Received: by 2002:a05:622a:98a:b0:534:dcbb:4920 with SMTP id d75a77b69052e-55d76a19c9emr540008471cf.42.1795874785928;
        Sat, 28 Nov 2026 06:06:25 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm230475611cf.17.2026.11.28.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:25 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 0/2] listns(): validate the reserved spare2 field
Date: Sat, 28 Nov 2026 17:06:21 +0300
Message-ID: <20261128140623.19-1-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
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

copy_ns_id_req() rejects a non-zero @spare but not @spare2, although
struct ns_id_req documents both as reserved.  Validate @spare2 the same
way, and extend the error-case selftest to cover it instead of only
@spare.

Nikolai Dokutovich (2):
  nstree: reject a non-zero spare2 in the listns() request
  selftests/namespaces: check that listns() rejects a non-zero spare2

 kernel/nstree.c                                  |  2 +-
 tools/testing/selftests/namespaces/listns_test.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

