Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577647;
	b=fPrBrsJlw9UHwmV5Bt2DI+6nexKE5obJb1iNKNFkYMZeo1skr0kljVgKdVRofWw1wQcg
	 y5Bmw6yeD5A9j1nZOrWg2HnTdBHzCtZ+tsuCj6WqIO3dmdi4J/jGHy6xi7hJseisWcvoe
	 9fXe+8hz1oF+oHu5o8GXr3DKpm2p1bHZwJ9KdGToPdLFMtjcjgUrWf3CRurVEWJJGAXcf
	 rLCzL5MQ+DGFd576f//cYUKKKXOd+aSOzHydmMzl8SedOS+CWkmA0DBzJR7yxVlKb5kt8
	 kDg5MLLPD7oC4pRFBlUDB9jd9q5dt09DE39b84DQ9YeonU5UdJrmWrC+iRQWffg/+WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kLkSOcJpYReFLUI0Gi+43gyJKNu0BPMvCXqZSLQ886Y=;
	b=XyMGY6eym6jAG32hJNw65iO1MpfDw3OLrNmeQr+qWMwiQmtmrRXUfJjsfwPB/nxZJzj8
	 pNGyuBn013A/TQxSclFI8ee2J8+jF8Wpcvxp8SH91uLtGsMauFa5DDoUTWa/KCptOFhW1
	 3FZQv/GIVaVXmRFgLLidMRZAcWl8W34be72d4JsgLFMeCf2dzD1G9b9H9uBIknu88FcBv
	 hoZY6gQv2LqNCoDZgRrR3jJVMimQeiczlOs8z2DJFH6Mb4TcC6O2sahO+QUWCiM1PQSKS
	 sYzByS2RMcqVq6eBpFQDW4HEUTdQV84Ma7A4OKypTmbwZT1pHAndTEDV+jxEtAre6Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YN+3fIeR;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D1606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C07D1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YN+3fIeR
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb8931aeeaso522904a12.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577646; x=1795182446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLkSOcJpYReFLUI0Gi+43gyJKNu0BPMvCXqZSLQ886Y=;
        b=YN+3fIeRCj5FYZK2CTRBYWPgIwK3Modi0TuaTLObsBjVn4ZWo35fyvSYP8SK8Q77Rn
         2pVkvHg89Posq5P80+RhszdyLd9K5Fbf0PDbWocsD7GSXpwA0dCVR433ZCKpIS10A0xh
         1rzy8p2bsSatQxBLLuTH3FXlhqyD8nSUxlfPe6mizkdlSVBtqSKKi/t4Q+K47ut1pXso
         wtq3SEtqTse0Is7KCEbXvTYXVm1xHs0uWzMmiNUfbdPSIDW8fPz0YaPCkGtWZM6K4Lfj
         hwX6bzueWtIzOsl9a1qMw2U3Si3NbD+6aYCQgOpfNRUUdVV7cD0R9HHWhBAaVumqoo5s
         HSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577646; x=1795182446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLkSOcJpYReFLUI0Gi+43gyJKNu0BPMvCXqZSLQ886Y=;
        b=pKL0PUf9a/avDYBdXqG2XxHywkcMDIgJHPn5dzos592Fk1HjqQ93ZaHSJQfZw+tIDA
         B4CZUFaOnXo26JnaM0xAsTHxPXfCe27U9d3lTONw2H+1aIVMoVSGOUV2OSKwwdzaW6uM
         ZkUmlh+TEUNKCjn4HCpI3itiSWVe7UDEm/2bpn/b/fFtABi1Tt1lcUrXKEqJCIxEHjcn
         oIq4AW3vvpurv34thpHpZR3S46K9ja0ajnyUo28P143McLDXdnP4eP/1nEtZRSzwObR7
         jPgWB8fgnUW+AICz5W64jyWNPW5bvRq6azVwwTnKM4JfiBjn2bBegIYy1ulxD/ewzryf
         gDnQ==
X-Forwarded-Encrypted: i=1; AL+hErEOMXRiYWMIMxO4jMjnBd3uo5eEqKjtvoPA0g3tJZbqvtETBU9wcDOfOwQAavhHOAdb1MN0Luk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fBpLbCRsmZkvck1XbOqiEFpyaYeH6iz2/uwQEkbsg6zIWHLNy
	pRt3IRJPsOqlXR2oQRtxSJUNUf6nhwu0o/jJLL9sc1WTDHVB7qbSg6j6Qg57Gl3pUi2cPbpqzeg
	AQzC0ew==
X-Received: from plbl7.prod.google.com ([2002:a17:902:eb07:b0:2eb:50b1:b505])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1647:b0:3b1:2d60:66cc
 with SMTP id 98e67ed59e1d1-3b1b07feb76mr2151845a91.8.1794577645893; Fri, 13
 Nov 2026 05:47:25 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:12 -0800
In-Reply-To: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441749877.74221.21689652864513523.b4-ty@b4>
Subject: Re: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 17 Oct 2026 11:30:10 +0200, Amirmohammad Eftekhar wrote:
> vmx_leave_smm() consumes nested.smm.vmxon into nested.vmxon up front, but
> clears nested.smm.guest_mode only on the success path.  On either failure
> arm (nested_vmx_check_restored_vmcs12() < 0, or
> nested_vmx_enter_non_root_mode() != NVMX_VMENTRY_SUCCESS) it returns early
> with nested.smm.guest_mode still true while nested.smm.vmxon is already
> false.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2
      https://github.com/kvm-x86/linux/commit/bcc359264f15

--
https://github.com/kvm-x86/linux/tree/next
