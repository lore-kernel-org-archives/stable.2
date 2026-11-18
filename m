Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994553;
	b=eqfD+HiJkfYSP6gBGIX4I6znbfUvY1kl4cTf6WKzPv7Vx4mvddW514+7oPyiuwxqZjvG
	 GiTszC7rRx/llmNg6RZOGVJ9taFP1BfriIGoebL9ywixNI4oJcfg/rqyTIlP/1GFc/HqD
	 3F7KW7pg9bAJpLkSJiS0IpcAu4vZOvXWvhVg+/6v0eQhdfpAnVLVVNyZj6AazhS+fDdmK
	 shlVA8Fuid1ia37AeTrNDDHVx1KAFt3q/H1ODJDmJ2tzFKCQ7CPMcZ0LRKamgrJob6/zL
	 Eq8O2jWTZ8IN7+bpGDwQT+gQe9s8HHFi3vNsm/Mn7DzxP2aChz5IB6g8U4GBBXsU8Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=l4/AfoH5qtsktDGlgqnQkJetFNnwwrHfiT5OhfTorx0=;
	b=tGjrv3vZir2ZEEMBmQZFBUX2hVtIdRe7NljdfwSu8vZtOfuaPiqIQhoc0IVklhzwFjvt
	 Xzi14X0Ry9NScSgQTAOPEDK7To2iRF5v5ZVtYff7WWsxhloaIX7C6+veFfrtjI81pL+wT
	 EoWAZskvnSi6lcOFwOgpsms7DI3BuivW93U3xYBrYsFTxoBPHr5FO3WYEdtDFIz56zomC
	 1vslaLJCS3xjV9aS45ycflLMg0Sns7NSxNoxx+Ra355ogHu0xiuN6dVBpXunzOzEZYuBQ
	 XNjDtmZLP1DIT5fZjRPMi6AhitcyafJUWhQEkPgyoBgx0no73GzVQQ7nsSEN0MDOc+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=oZHsLWdp;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47F606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC47F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=oZHsLWdp
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50cc7540b7so92359366b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794994551; x=1795599351; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4/AfoH5qtsktDGlgqnQkJetFNnwwrHfiT5OhfTorx0=;
        b=oZHsLWdpNrywGLboUZDutaadO2GkeZAyMaSEojOUxjcJMDYrP1CB44yoBUQ0hykPqk
         9cnSKWDx3Y3V7WZPqDlBeMjDKQm8EGbR6J4naz76o9s78XOlb8PTkW8vtJZLE8tJCd9M
         yuSr8EennPDpuCvisldirR/aAh2kGa6NLCHmluvvAvuDYWX+K3UrNOy+v245za6HoKOm
         vel77RfP4efhAaRIYhAuEHBfgfzjyJVc88yaKP/sovTjXvC9vj4UEzbPAuW4Dsr6teFn
         sor3uBjSEPhdANG7r5WAXYE6uGGJV9cMExXLAHl2CYOr5lCYcHxlEkDbrT1VYEE2mBq5
         YySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994551; x=1795599351;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4/AfoH5qtsktDGlgqnQkJetFNnwwrHfiT5OhfTorx0=;
        b=yAWM7IA4kV3OjKgorlL+DGtolaFH5PsArdP9oqrv4fBqBD5OQcrL1tFz8JL2ZDVyLd
         yRqfSHa5j4W4VDR2POEi2C24a75uqE76x98t40BdWKbJN4kgHdHgRldxwslVx00X4iRA
         bCikl9ixiYqmeZyRGiWogoHUZUzn5nf58ZdRsI74J1h0bNts7/wfTbKyTtVrpzyXMKCX
         5EnVRZ74cLTF87vdD9fCCu3UEbcMUckHibFe90/GPGULPeVeMENphLsaS/z8uE47t0Wc
         Nmuao0kfAvaK557FgCVq20IKsR8rDZjPtgIF3rL2tRJTDlo4x315vXlnHwyD6sV8aTQf
         dECw==
X-Gm-Message-State: APuU4Z+PIpLG4YpSc1zFDrlEH+8y8XdlXGXGp1kWtF07OhzpVbcNKt4A
	z4ynSfzw+RoFtP6/XLbWhWOreR4op366eipi1FfGgdMJsZdwbL8utoPmCdLvXk5OFehZEAbs9au
	HMcKuY4Byjg==
X-Gm-Gg: AYBFou1SvVbRznDIJmT1+1GexbXO7X1jaLHxmaa+TGUNdJuwhx92DcqI0SyDhFvqdG1
	z6uzSLAWfLQWxlJB5hQdSCDIA+VB7Ab1zroB391rTyyJmG6NfsHsW/ikQFrOMQ9G90W97jt5KpW
	qR0N6iEj2CWaADuHOC/fa7YAx24Shp9jGSPn4Hc9iPT+Dhv+Igcr/ETmNYgGm+2F4EpZ6/LAOMS
	3FvWOBeu6b2Hv3tcVxR5Rho/Aj36Q0/X6OII5EsRW7gBoKDaqy44NVhZZ33linPsiVITjY9//zB
	qqjFxp3tqQgVIwSIZnnGX4Zq8vLuQrEG/Pj5B4NhPMm/fqIwu5JF8Ke2ye8khXlBFrs58FWznD5
	SmsVp/S5sE42V+JXXGDJvmDiBiEUfrdiqHbzNHLxTqI8kiYoBPOkO3pfn7+Y2vqElzLay5mSCAf
	hbPt8a+iJyzHRG4jxTUMG82KrQNtPfGtraezP/vLC/CwgXAkhO29x4W3xo2zsezj1NRL7WRIxHx
	NtMinNOn8+70PQ/iQc82HY1nAaEgFyTFkmoE//KYUzevbtsPXlYlapt0EX6HEKup/XCxxUwC4cc
	MKfuzifW8x+D6Umr74K5FYKUjc4wR8p2YzlCbB/QxHaEkScol37WYGSBYMah/JNlI5DhzYPi5ky
	Y2nz8EA==
X-Received: by 2002:a17:907:72c9:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c510dc797e9mr190923066b.0.1794994551014;
        Wed, 18 Nov 2026 01:35:51 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab3000sm75275066b.56.2026.11.18.01.35.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:35:50 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Nov 2026 10:35:44 +0100
Subject: [PATCH 5.15.y 5.10.y 4/4] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
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
Message-Id: <20261118-openssl4-515-v1-4-e1fbd1da96d4@fairphone.com>
References: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
In-Reply-To: <20261118-openssl4-515-v1-0-e1fbd1da96d4@fairphone.com>
To: stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794994548; l=2345;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=IFtEtOls0MTjRM05vLvDPeBYQ476A3gj7lHW6aXY3wg=;
 b=jKeCC5pI22PMYkSSsSWbYd6Aa+L3fkrHzQnr7H86DX8fq7tjyQnAy5RM1XOkrQIrm/NzCTnmv
 YADQ7bGORhcDvW7yRBDA7ZLVFTyRVPcgRfPCUDNn2xSSeKFjvYIXJFV
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Nathan Chancellor <nathan@kernel.org>

commit 4f96b7c68a9904e01049ef610d701b382dca9574 upstream.

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in certs/extract-cert.c:

  certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
     46 | static const char *key_pass;
        |                    ^

After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
API, not the new provider API. Wrap key_pass's declaration and
assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
with its use to clear up the warning. While this is a little uglier than
just marking key_pass with the unused attribute, this will make it
easier to clean up all code associated with the use of the engine API if
it were ever removed in the future. While in the area, use a tab for
the key_pass assignment line to match the rest of the file.

Cc: stable@vger.kernel.org
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://patch.msgid.link/20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 scripts/extract-cert.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index 6d9886024c5d..646cc4d4f968 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -43,7 +43,9 @@ void format(void)
 	exit(2);
 }
 
+#ifdef USE_PKCS11_ENGINE
 static const char *key_pass;
+#endif
 static BIO *wb;
 static char *cert_dst;
 static int kbuild_verbose;
@@ -132,7 +134,9 @@ int main(int argc, char **argv)
 
 	kbuild_verbose = atoi(getenv("KBUILD_VERBOSE")?:"0");
 
-        key_pass = getenv("KBUILD_SIGN_PIN");
+#ifdef USE_PKCS11_ENGINE
+	key_pass = getenv("KBUILD_SIGN_PIN");
+#endif
 
 	if (argc != 3)
 		format();

-- 
2.56.1

