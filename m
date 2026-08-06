Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906236F41C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983171; cv=none; b=l87yjTiYUjbYO3zq7Ou0IydKwxJN7rSVYW2CLqGav9zolYm3CZhAe2EnrJlKx4QcUa0DSmG6LCtdbT3kmwZkXp6q706P7wf7Z5V4ErEXp0innl5HcgF0phVo4k8ujw5l0xoD5FB3PiZpXhoICC6HZc6yWwof5YJtvrueMiB0Mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983171; c=relaxed/simple;
	bh=YzAh+YD6lKilHoBSKwXJcgZGR1dmvSIzVdLvGSf3MxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DL14oIldAi1znDgC5Z3SxFO/66EXBLTZ/c4WKTSgUgyYQrHWZIfFZGpXwbkSRZx1OX/Y/Xe/eN0dWxZIh7iT5VdVpDVBG/8QtAO4Hzu/B39mNrS2ueY17JQE/MEf9suNWdTQh/EPKbAYI/EWMgnKZCG6BmopzSW3oxUXrg8amls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqQbXZx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqQbXZx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC841F00A3D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983170;
	bh=pvK42fe7+pMj95jx5RODOjowEvyVswQOGNdHwCji0RA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QqQbXZx16OGMtrBT7e2sUwtzjbkV/G4EL99dtIvRvSNiPI3mLTIr54AOZaaWZAN2N
	 LKXDablw47up7glqU+yVp9RQkNgO1zolUKXLGyh8uFsMksvHbe2Kand9bV/aG58Gwk
	 +w85BtPnPOSDGROeRsuXcdiirY2xDJb+2osgaEbMJyIbkkYCVaqjda7QxLMEdrj2q6
	 caA4r0p/iwiTbTN77uDuuUamCQ+zhbYnfmx7XZ9HFhy6daQH6S65wYgxVhWEdlSshi
	 HMkSSkC/eP/WFPS4Iq/uj1JwrDDcaoziLNx1XEuQujjmwGixxEpJ0dVcO2ySFvmYiP
	 zKOWvbryYvXkw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so215585466b.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 19:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqfdCTD/1oHnO8IK9OU8K9iG8l6+WYqa1AQ/9Px2kRWqSV3dha878Xj6cqPz3Yq9Qs+fR0I7OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOMKA1tNmvPq/z55caQUgc66vLfdeYfltEiyuAafn0wCgVlwc
	lehYeMLw7nywGFWps3tHh/H2xi1ekTkF2EfmbpFMyHHVIOXJIBIfLW5LYLL3AU/TApzGbTaySC3
	taYUATs7vA556HuUCFEB8YNEgGi1FoWw=
X-Received: by 2002:a17:907:ea8c:b0:c20:34dd:5ee3 with SMTP id
 a640c23a62f3a-c2039cad20dmr605911766b.17.1785983168889; Wed, 05 Aug 2026
 19:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805092908.77549-1-zenghongling@kylinos.cn>
In-Reply-To: <20260805092908.77549-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 6 Aug 2026 11:25:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-sWh22TaDHJ-8cphDqC0rNY9=JoB4GioXT7CNGDcA2ZQ@mail.gmail.com>
X-Gm-Features: AUfX_mw7n3-aeWtyWIKht-UXFcL5J-3pv0aWiQ6YOtB43ehFhItyetOFp4YM9gA
Message-ID: <CAKYAXd-sWh22TaDHJ-8cphDqC0rNY9=JoB4GioXT7CNGDcA2ZQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix name offset validation in ntfs_non_resident_attr_value_is_valid
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, alexandro.calo@nozominetworks.com, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005b82420658579c74"

--0000000000005b82420658579c74
Content-Type: text/plain; charset="UTF-8"

> @@ -706,7 +709,35 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
>                 return false;
>
>         mp_offset = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
> -       return mp_offset >= min_len && mp_offset <= attr_len;
> +       if (mp_offset < min_len || mp_offset > attr_len)
> +               return false;
> +
> +       /*
> +        * Validate name_offset for named attributes.
> +        * Unnamed attributes have name_length = 0 and name_offset may be 0.
> +        */
> +       name_len = le16_to_cpu(a->name_length);
name_length is a u8, not a __le16 field, so it must not be passed to
le16_to_cpu().

+               /*
+                * For non-sparse -> sparse conversion, name shifts forward
+                * by 8 bytes. Ensure there's room for the shift.
+                */
+               if (!(a->flags & ATTR_IS_SPARSE) &&
+                    name_end + 8 > attr_len)
+                       return false;
This check should not depend on name_length. Unnamed attributes also
need eight bytes of room when converting from non-sparse to sparse,
because compressed_size is added and mapping_pairs_offset is advanced
by eight bytes. Also, compressed attributes do not go through this
conversion, so the condition should exclude both sparse and compressed
attributes. how about adding the following check outside the if
(a->name_length) block?

                   if (!(a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK)) &&
                          attr_len - mp_offset <
                                 sizeof(a->data.non_resident.compressed_size))
                          return false;
Please check the attached patch.
Thanks.

--0000000000005b82420658579c74
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-validate-non-resident-attribute-offsets.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-validate-non-resident-attribute-offsets.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msgvmnpt0>
X-Attachment-Id: f_msgvmnpt0

RnJvbSA0MTgyZTExMmE3MzMyNjllZDIwOTE0ZDVjNDI2Y2FjMWMwZTIwMmVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIb25nbGluZyBaZW5nIDx6ZW5naG9uZ2xpbmdAa3lsaW5vcy5j
bj4KRGF0ZTogVGh1LCA2IEF1ZyAyMDI2IDEwOjU4OjMwICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
bnRmczogdmFsaWRhdGUgbm9uLXJlc2lkZW50IGF0dHJpYnV0ZSBvZmZzZXRzCgpudGZzX2F0dHJf
dXBkYXRlX21ldGEoKSBzaGlmdHMgdGhlIGF0dHJpYnV0ZSBuYW1lIHdoZW4gY29udmVydGluZyBi
ZXR3ZWVuCm5vbi1zcGFyc2UgYW5kIHNwYXJzZSBhdHRyaWJ1dGVzLiBDb252ZXJ0aW5nIHRvIHNw
YXJzZSBhbHNvIGFkZHMgdGhlCmNvbXByZXNzZWRfc2l6ZSBmaWVsZCBiZWZvcmUgdGhlIG5hbWUg
YW5kIG1hcHBpbmcgcGFpcnMsIHJlcXVpcmluZyBlaWdodAphZGRpdGlvbmFsIGJ5dGVzIGluIHRo
ZSBhdHRyaWJ1dGUgcmVjb3JkLgoKSG93ZXZlciwgdGhlIHZhbGlkYXRvciBkb2VzIG5vdCBjaGVj
ayB0aGF0IG5hbWVfb2Zmc2V0IGlzIHdpdGhpbiBzYWZlCmJvdW5kYXJpZXMgZm9yIHRoZXNlIG9w
ZXJhdGlvbnMgb3IgdGhhdCB0aGUgYWRkaXRpb25hbCBzcGFjZSBpcyBhdmFpbGFibGUuCkEgbWFs
aWNpb3VzIE1GVCByZWNvcmQgY291bGQgc2V0IG5hbWVfb2Zmc2V0IHN1Y2ggdGhhdDoKCjEuIFRo
ZSBuYW1lIGlzIHBvc2l0aW9uZWQgYXQgdGhlIHZlcnkgZW5kIG9mIGEgbm9uLXNwYXJzZSBhdHRy
aWJ1dGUuCiAgIENvbnZlcnRpbmcgdG8gc3BhcnNlIHdvdWxkIHNoaWZ0IHRoZSBuYW1lIGZvcndh
cmQgYnkgOCBieXRlcywKICAgd3JpdGluZyBiZXlvbmQgdGhlIGF0dHJpYnV0ZSBib3VuZGFyeS4K
CjIuIFRoZSBuYW1lIG92ZXJsYXBzIHdpdGggdGhlIG1hcHBpbmcgcGFpcnMsIGNhdXNpbmcgY29y
cnVwdGlvbiBkdXJpbmcKICAgY29udmVyc2lvbi4KCkFkZCB2YWxpZGF0aW9uIHRvIGVuc3VyZToK
LSBGb3IgbmFtZWQgYXR0cmlidXRlcywgbmFtZV9vZmZzZXQgaXMgd2l0aGluIHZhbGlkIGJvdW5k
cwotIE5hbWUgZG9lcyBub3QgZXh0ZW5kIGJleW9uZCB0aGUgYXR0cmlidXRlIG9yIG92ZXJsYXAg
d2l0aCBtYXBwaW5nIHBhaXJzCi0gRm9yIG5vbi1zcGFyc2UsIG5vbi1jb21wcmVzc2VkIGF0dHJp
YnV0ZXMsIGVpZ2h0IGJ5dGVzIGFyZSBhdmFpbGFibGUKICBhZnRlciBtYXBwaW5nX3BhaXJzX29m
ZnNldCBmb3IgdGhlIGNvbXByZXNzZWRfc2l6ZSBmaWVsZAoKVGhlIHNwYWNlIGNoZWNrIGFsc28g
Y292ZXJzIHVubmFtZWQgYXR0cmlidXRlcywgZm9yIHdoaWNoIG5hbWVfb2Zmc2V0ID0gMAppcyB2
YWxpZCBhbmQgbm8gbmFtZSByYW5nZSBuZWVkcyB0byBiZSBjaGVja2VkLgoKRml4ZXM6IDdlMmEx
YzU1NGJjNCAoIm50ZnM6IEZpeCBtaW5fbGVuIGZvciBjb21wcmVzc2VkL3NwYXJzZSBhdHRyaWJ1
dGVzIGluIG50ZnNfbm9uX3Jlc2lkZW50X2F0dHJfdmFsdWVfaXNfdmFsaWQoKSIpCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEhvbmdsaW5nIFplbmcgPHplbmdob25n
bGluZ0BreWxpbm9zLmNuPgpDby1kZXZlbG9wZWQtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9u
QGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5l
bC5vcmc+Ci0tLQogZnMvbnRmcy9hdHRyaWIuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysr
LQogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9mcy9udGZzL2F0dHJpYi5jIGIvZnMvbnRmcy9hdHRyaWIuYwppbmRleCBkZDZhZGUy
OTc5ODguLjkwYzNmNjg4NjZlZiAxMDA2NDQKLS0tIGEvZnMvbnRmcy9hdHRyaWIuYworKysgYi9m
cy9udGZzL2F0dHJpYi5jCkBAIC02OTMsNiArNjkzLDggQEAgc3RhdGljIGJvb2wgbnRmc19ub25f
cmVzaWRlbnRfYXR0cl92YWx1ZV9pc192YWxpZChjb25zdCBzdHJ1Y3QgYXR0cl9yZWNvcmQgKmEp
CiAJdTMyIGF0dHJfbGVuOwogCXUzMiBtaW5fbGVuOwogCXUxNiBtcF9vZmZzZXQ7CisJdTE2IG5h
bWVfb2Zmc2V0OworCXUzMiBuYW1lX2VuZDsKIAogCWF0dHJfbGVuID0gbGUzMl90b19jcHUoYS0+
bGVuZ3RoKTsKIAltaW5fbGVuID0gb2Zmc2V0b2Yoc3RydWN0IGF0dHJfcmVjb3JkLCBkYXRhLm5v
bl9yZXNpZGVudC5pbml0aWFsaXplZF9zaXplKSArCkBAIC03MDYsNyArNzA4LDI3IEBAIHN0YXRp
YyBib29sIG50ZnNfbm9uX3Jlc2lkZW50X2F0dHJfdmFsdWVfaXNfdmFsaWQoY29uc3Qgc3RydWN0
IGF0dHJfcmVjb3JkICphKQogCQlyZXR1cm4gZmFsc2U7CiAKIAltcF9vZmZzZXQgPSBsZTE2X3Rv
X2NwdShhLT5kYXRhLm5vbl9yZXNpZGVudC5tYXBwaW5nX3BhaXJzX29mZnNldCk7Ci0JcmV0dXJu
IG1wX29mZnNldCA+PSBtaW5fbGVuICYmIG1wX29mZnNldCA8PSBhdHRyX2xlbjsKKwlpZiAobXBf
b2Zmc2V0IDwgbWluX2xlbiB8fCBtcF9vZmZzZXQgPiBhdHRyX2xlbikKKwkJcmV0dXJuIGZhbHNl
OworCisJaWYgKGEtPm5hbWVfbGVuZ3RoKSB7CisJCW5hbWVfb2Zmc2V0ID0gbGUxNl90b19jcHUo
YS0+bmFtZV9vZmZzZXQpOworCisJCWlmIChuYW1lX29mZnNldCA8IG1pbl9sZW4gfHwgbmFtZV9v
ZmZzZXQgPj0gYXR0cl9sZW4pCisJCQlyZXR1cm4gZmFsc2U7CisKKwkJbmFtZV9lbmQgPSBuYW1l
X29mZnNldCArIGEtPm5hbWVfbGVuZ3RoICogc2l6ZW9mKF9fbGUxNik7CisJCWlmIChuYW1lX2Vu
ZCA+IGF0dHJfbGVuIHx8IG5hbWVfZW5kID4gbXBfb2Zmc2V0KQorCQkJcmV0dXJuIGZhbHNlOwor
CX0KKworCS8qIEVuc3VyZSB0aGVyZSdzIHJvb20gZm9yIHRoZSBjb21wcmVzc2VkX3NpemUgZmll
bGQgaWYgbmVlZGVkLiAqLworCWlmICghKGEtPmZsYWdzICYgKEFUVFJfSVNfU1BBUlNFIHwgQVRU
Ul9DT01QUkVTU0lPTl9NQVNLKSkgJiYKKwkgICAgYXR0cl9sZW4gLSBtcF9vZmZzZXQgPAorCQkJ
c2l6ZW9mKGEtPmRhdGEubm9uX3Jlc2lkZW50LmNvbXByZXNzZWRfc2l6ZSkpCisJCXJldHVybiBm
YWxzZTsKKworCXJldHVybiB0cnVlOwogfQogCiBzdGF0aWMgYm9vbCBudGZzX2F0dHJfdmFsdWVf
aXNfdmFsaWQoc3RydWN0IG50ZnNfdm9sdW1lICp2b2wsCi0tIAoyLjM0LjEKCg==
--0000000000005b82420658579c74--
